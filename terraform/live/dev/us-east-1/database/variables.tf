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

variable "db_name" {
  type        = string
  description = "Name of the initial PostgreSQL database to create"
}

variable "db_username" {
  type        = string
  description = "Master username for the RDS instance"
}

variable "instance_class" {
  type        = string
  description = "Instance class for the RDS instance"
  default     = "db.t3.micro"
}

variable "is_failover" {
  type        = bool
  description = "When true, creates the DB as a cross-region read replica for DR"
  default     = false
}

variable "source_db_arn" {
  type        = string
  description = "ARN of the primary RDS instance to replicate from; required when is_failover = true"
  default     = ""
}
