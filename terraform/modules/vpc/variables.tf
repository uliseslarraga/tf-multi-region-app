variable "region" {
  type        = string
  description = "AWS region where the VPC is provisioned (used to derive AZ names)"
}

variable "vpc_name" {
  type        = string
  description = "Base name used in resource Name tags (e.g. main-dev)"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC; subnets are carved from this using cidrsubnet"
}

variable "environment" {
  type        = string
  description = "Deployment environment (dev, staging, prod)"
}

variable "az_subnets_number" {
  type        = number
  default     = 3
  description = "Number of subnets to create per tier, one per AZ"
}

variable "tags" {
  type        = map(string)
  description = "Common tags applied to all resources in this module"
}