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
  description = "Instance class for the primary RDS instance"
  default     = "db.t3.micro"
}
