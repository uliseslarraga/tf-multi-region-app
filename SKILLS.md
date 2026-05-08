# SKILL.md — Root

This file defines Terraform coding standards for this repository.
Claude Code must follow these conventions in every file it generates or modifies.

## Terraform style

- Use `snake_case` for all resource names, variable names, and output names
- One resource per `.tf` file is NOT required — group by concern (e.g. `sg.tf` for all security groups)
- Always pin provider versions in `provider.tf` — do not use `~>` unless explicitly asked
- No inline `lifecycle` blocks unless the resource genuinely needs `prevent_destroy` or `ignore_changes`
- Prefer explicit over implicit — avoid `count` when `for_each` is clearer

## File layout rules

Every root module must contain exactly these files — no more, no less unless asked:
| File | Purpose |
|---|---|
| `provider.tf` | AWS provider block, pinned version |
| `backend.tf` | S3 backend config |
| `variables.tf` | All input variables with type + description |
| `terraform.tfvars` | Environment/region-specific values |
| `outputs.tf` | Outputs consumed by other layers |
| Layer-specific `.tf` files | e.g. `vpc_main.tf`, `sg.tf`, `vpc_endpoints.tf` |

Do not create `main.tf` — this project uses descriptive filenames instead.

## Variables

- Every variable needs `type`, `description`, and `default` (or a comment explaining why there is none)
- Sensitive variables must be marked `sensitive = true`
- Region-specific values belong in `terraform.tfvars`, never hardcoded in `.tf` files
- Standard variables every root module must declare:

```hcl
variable "region" {
  type        = string
  description = "AWS region for this root module"
}

variable "environment" {
  type        = string
  description = "Deployment environment (dev, staging, prod)"
}

variable "project" {
  type        = string
  description = "Project name used in tags and resource naming"
  default     = "three-tier-infra"
}
```

## Tagging

Every resource that supports tags must include:

```hcl
tags = {
  Project     = var.project
  Environment = var.environment
  ManagedBy   = "terraform"
}
```

Use a `locals.tf` file with a `common_tags` local when a root module has 4+ taggable resources:

```hcl
locals {
  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}
```

Then reference as `tags = local.common_tags` or `tags = merge(local.common_tags, { Name = "..." })`.

## Naming convention

Resource `Name` tags follow: `{project}-{environment}-{region-short}-{resource-type}`

Region shortcodes:
- `us-east-1` → `use1`
- `us-west-2` → `usw2`

Examples:
- VPC: `three-tier-infra-dev-use1-vpc`
- Subnet: `three-tier-infra-dev-use1-ingress-subnet-a`
- Security group: `three-tier-infra-dev-use1-app-sg`

## Outputs

- Every output needs a `description`
- Outputs that will be consumed by another layer must be documented in CLAUDE.md under "Output contract"
- Never output sensitive values unless marked `sensitive = true`

## What NOT to do

- Do not use `terraform.workspace` — environments are separated by directory, not workspace
- Do not create resources in `terraform/global/` — it is a placeholder
- Do not modify `bootstrap/` — it is a one-time manual step
- Do not use `data` sources to look up the VPC by tag — always consume via remote state outputs
- Do not add `us-west-2` implementation unless explicitly asked
- Do not generate a `main.tf` file

## Module design philosophy

This project uses small, single-responsibility modules — not fat layer modules.
Each module provisions one logical unit. Examples:

| Module | Provisions |
|---|---|
| `modules/vpc` | VPC + subnets + route tables |
| `modules/alb` | Application Load Balancer + listeners + target groups |
| `modules/asg` | Launch template + Auto Scaling Group + instance profile |
| `modules/rds` | RDS instance or cluster + subnet group + parameter group |
| `modules/sg` | Security group + rules for a named role (e.g. "web", "app", "db") |

### Rules for all modules

- One module = one AWS concept. If a module provisions two unrelated things, split it.
- Modules never call other modules. Composition happens in the root module only.
- Modules never contain `provider` or `backend` blocks.
- Modules receive IDs as input variables — never look up resources with `data` sources internally.
  - ✅ `variable "vpc_id"` passed in from the root module
  - ❌ `data "aws_vpc"` looked up by tag inside the module
- Every module must have a `variables.tf`, `main.tf`, and `outputs.tf` at minimum.
  - Exception: root modules use descriptive filenames instead of `main.tf` (see File layout rules above)

### Module interface pattern

Inputs follow this convention:
- Accept the minimum needed — no "pass-through" variables that just forward to a sub-resource unchanged
- Group related IDs into a list when order doesn't matter (e.g. `subnet_ids = list(string)`)
- Accept `common_tags` as a variable so the root module controls tagging

```hcl
variable "common_tags" {
  type        = map(string)
  description = "Common tags applied to all resources in this module"
  default     = {}
}
```

Outputs follow this convention:
- Always output the primary resource ID and ARN
- Output anything a sibling module might need as an input (e.g. `target_group_arn` from `modules/alb`)

### CIDR allocation

CIDRs are computed dynamically using `cidrsubnet` — never hardcode IP ranges.

#### VPC per region
Each region gets a `/16` slice from the root supernet using a region index:

```hcl
cidr_block = cidrsubnet(var.cidr, 2, <region_index>)
```

| Region | Index | Resulting VPC CIDR |
|---|---|---|
| us-east-1 | 0 | 10.0.0.0/16 |
| us-west-2 | 1 | 10.1.0.0/16 |

The root supernet variable (`var.cidr`) is passed into the network root module via `terraform.tfvars`.

#### Subnets per tier
Each VPC is divided into 3 tiers × 3 AZs using `/20` blocks. `var.az_subnets_number = 3`.

```hcl
# Ingress — slots 0, 1, 2
cidrsubnet(var.cidr_block, 4, count.index)

# App — slots 3, 4, 5
cidrsubnet(var.cidr_block, 4, var.az_subnets_number + count.index)

# Data — slots 6, 7, 8
cidrsubnet(var.cidr_block, 4, (var.az_subnets_number * 2) + count.index)
```

#### Rules
- Always use `cidrsubnet` — never replace with hardcoded CIDR strings
- Never change the offset formula without updating all regions consistently
- `var.az_subnets_number` must always equal the number of AZs (currently 3)
- Adding a new region = increment the region index, never reuse an existing one