locals {
    common_tags = {
      Environment = var.environment
      Terraform   = "true"
    }
    cidr_block = cidrsubnet(var.cidr, 2, 0)
}

variable "cidr" {
  type = string
}

variable "region" {
  type = string
}

variable "environment" {
  type = string
}