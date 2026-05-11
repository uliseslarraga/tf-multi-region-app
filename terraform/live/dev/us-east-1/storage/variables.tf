variable "aws_region" {
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

variable "force_destroy" {
  type        = bool
  description = "Allow bucket deletion even when it contains objects"
  default     = false
}

variable "enable_replication" {
  type        = bool
  description = "Enable cross-region replication to us-west-2; requires the us-west-2 storage layer to be deployed first"
  default     = false
}
