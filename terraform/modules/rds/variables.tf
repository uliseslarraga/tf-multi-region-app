variable "name_prefix" {
  type        = string
  description = "Name prefix for all resources (e.g. three-tier-infra-dev-use1)"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of data-tier subnet IDs for the DB subnet group"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security group IDs to attach to the DB instances"
}

variable "db_name" {
  type        = string
  description = "Name of the initial database to create"
}

variable "username" {
  type        = string
  description = "Master username for the DB instance"
}

variable "password" {
  type        = string
  description = "Master password for the DB instance"
  sensitive   = true
}

variable "engine_version" {
  type        = string
  description = "PostgreSQL engine version (e.g. 16.3)"
  default     = "16.3"
}

variable "instance_class" {
  type        = string
  description = "Instance class for the primary DB"
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  type        = number
  description = "Initial allocated storage in GiB"
  default     = 20
}

variable "max_allocated_storage" {
  type        = number
  description = "Upper limit for storage autoscaling in GiB (set equal to allocated_storage to disable)"
  default     = 100
}

variable "storage_type" {
  type        = string
  description = "Storage type for the primary (gp2, gp3, io1)"
  default     = "gp3"
}

variable "storage_encrypted" {
  type        = bool
  description = "Enable encryption at rest for the primary"
  default     = true
}

variable "multi_az" {
  type        = bool
  description = "Deploy the primary across multiple AZs for HA (required for blue/green deployments)"
  default     = true
}

variable "backup_retention_period" {
  type        = number
  description = "Days to retain automated backups (must be > 0 to enable blue/green deployments)"
  default     = 1
}

variable "deletion_protection" {
  type        = bool
  description = "Prevent accidental deletion of DB instances"
  default     = false
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Skip final snapshot when the DB instance is destroyed"
  default     = true
}

variable "is_failover" {
  type        = bool
  description = "When true, the instance is created as a cross-region read replica of source_db_arn (DR mode)"
  default     = false
}

variable "source_db_arn" {
  type        = string
  description = "ARN of the primary DB instance to replicate from; required when is_failover = true"
  default     = ""
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags applied to all resources in this module"
  default     = {}
}
