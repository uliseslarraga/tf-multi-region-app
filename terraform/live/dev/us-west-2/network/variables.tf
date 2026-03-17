locals {
    common_tags = {
      Environment = var.environment
      Terraform   = "true"
    }
    cidr_blocks = {
      app     = cidrsubnet(var.cidr, 2, 0)
      data    = cidrsubnet(var.cidr, 2, 1)
      ingress = cidrsubnet(var.cidr, 2, 2)
    }
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