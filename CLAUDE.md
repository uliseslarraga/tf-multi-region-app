# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Multi-region AWS infrastructure project using plain Terraform (no Terragrunt). Provisions a three-tier Layer Network architecture in a single VPC across `us-east-1` and `us-west-2`. The architecture separates concerns into Ingress, App, and Data layers per region. Bootstrap folder has a Cloudformation template to create s3 backend. 

## Common Commands

### Bootstrap (one-time, creates S3 backend bucket)
```bash
aws cloudformation create-stack --stack-name tf-state-stack --template-body file://bootstrap/backend.yaml
```

### Terraform workflow (run from within each root module directory)
```bash
terraform -chdir=terraform/live/dev/us-east-1/{layer} init
terraform -chdir=terraform/live/dev/us-east-1/{layer} plan
terraform -chdir=terraform/live/dev/us-east-1/{layer} apply
terraform -chdir=terraform/live/dev/us-east-1/{layer} destroy
```

Each region's network stack is an independent root module — `init`/`plan`/`apply` must be run separately per region.

## Repository Structure

```
bootstrap/           # CloudFormation template to create the S3 Terraform state backend
terraform/
  modules/vpc/       # Reusable VPC module (VPC + 3 subnets for ingress, 3 subnets for app and 3 subnets for databases across AZs a/b/c)
  modules/compute/   # Placeholder — not yet implemented
  global/            # Placeholder — not yet implemented
  docs/              # Network architecture docs and diagrams
  live/dev/
    us-east-1/network/   # Root module: networking stack for us-east-1
    us-west-2/network/   # Root module: networking stack for us-west-2 - not yet implemented
```

## Architecture

### App Architecture
Vault app that saves screenshots of web pages and its url
The app has a frontend page that requires an NGINX server and a backend midleware written in python, each app needs to run on a separate VM, so we need an internal ALB for backend autoscaling group and a public ALB for frontend App, both apps are stateless and save links and metadatada in a postgres database and an object repository storage like AWS s3.  

### CIDR allocation
CIDRs are computed dynamically via `cidrsubnet`. 
The root supernet per region is passed via `var.cidr` in `terraform.tfvars`.
See SKILL.md for the exact formula and rules.

### Layer hierarchy 
1.- Networking
2.- Database 
3.- Storage resources (S3,ebs,efs,etc) 
4.- Compute

### Layer separation

The `live/dev/{region}/network/` directories are each a self-contained Terraform root module with their own state file. File responsibilities within each:

| File(s) | Purpose |
|---|---|
| `vpc.tf` | Instantiate the `modules/vpc` module to create 3 tiers |
| `sg.tf`, `vpc_endpoints.tf` | Security groups and SSM interface endpoints |
| `provider.tf`, `backend.tf` | AWS provider and S3 backend config |
| `variables.tf`, `terraform.tfvars` | Region-specific parameterization |
| `outputs.tf` | VPC/subnet IDs for consumption by future layers |


### Traffic flow
- Ingress ↔ App (bidirectional)
- App ↔ Data (bidirectional)
- Ingress ↛ Data (no direct path)

VPC Endpoints (SSM, SSMMessages, EC2Messages) in App subnets enable Systems Manager access without an internet gateway.

### Remote state

S3 backend with state locking (`use_lockfile = true`). Each root module has its own key:
- `dev/us-east-1/network/terraform.tfstate`
- `dev/us-west-2/network/terraform.tfstate`

Bucket: `tf-backend-bucket-culr-03-2026`

## Conventions

- Each new region or environment gets its own root module directory under `live/{env}/{region}/{layer}/`.
- New shared infrastructure goes in `terraform/modules/` as a reusable module.
- Global/cross-region resources belong in `terraform/global/` (not yet used).
- AWS provider version is pinned in `provider.tf` per root module (currently 6.36.0).

## Output Contract

Outputs exposed by `live/dev/{region}/network/outputs.tf` for consumption by downstream layers via remote state.

| Output key | Type | Description |
|---|---|---|
| `main_vpc` | `string` | VPC ID of the single regional VPC |
| `ingress_subnets` | `list(string)` | Subnet IDs for the Ingress tier (one per AZ) |
| `app_subnets` | `list(string)` | Subnet IDs for the App tier (one per AZ) |
| `data_subnets` | `list(string)` | Subnet IDs for the Data tier (one per AZ) |

### How to consume

```hcl
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "tf-backend-bucket-culr-03-2026"
    key    = "dev/us-east-1/network/terraform.tfstate"
    region = "us-east-1"
  }
}

# Example usage
vpc_id     = data.terraform_remote_state.network.outputs.main_vpc
subnet_ids = data.terraform_remote_state.network.outputs.app_subnets
```