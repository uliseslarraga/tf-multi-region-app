variable "cidr" {
  type        = string
  description = "Supernet CIDR block for this region (e.g. 10.0.0.0/14); App, Data, and Ingress subnets are carved from this"
}

variable "region" {
  type        = string
  description = "AWS region for this root module (e.g. us-east-1)"
}

variable "environment" {
  type        = string
  description = "Deployment environment (dev, staging, prod)"
}

variable "project" {
  type        = string
  description = "Project name used in tags and resource naming"
}