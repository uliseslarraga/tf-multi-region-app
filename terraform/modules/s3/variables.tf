variable "name_prefix" {
  type        = string
  description = "Name prefix for all resources (e.g. vault-web-dev-use1)"
}

variable "environment" {
  type        = string
  description = "Deployment environment (dev, staging, prod)"
}

variable "force_destroy" {
  type        = bool
  description = "Allow bucket deletion even when it contains objects"
  default     = false
}

variable "replication_destination_bucket_arn" {
  type        = string
  description = "ARN of the destination S3 bucket for cross-region replication; leave empty to disable CRR"
  default     = ""
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags applied to all resources in this module"
  default     = {}
}
