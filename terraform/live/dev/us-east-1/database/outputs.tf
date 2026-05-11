output "db_endpoint" {
  description = "Connection endpoint for the RDS instance (host:port)"
  value       = module.rds.endpoint
}

output "db_address" {
  description = "Hostname of the RDS instance"
  value       = module.rds.address
}

output "db_port" {
  description = "Port the RDS instance listens on"
  value       = module.rds.port
}

output "db_name" {
  description = "Name of the PostgreSQL database"
  value       = var.db_name
}

output "db_secret_arn" {
  description = "ARN of the Secrets Manager secret holding RDS credentials — for consumption by the compute layer"
  value       = aws_secretsmanager_secret.db.arn
}

output "db_security_group_id" {
  description = "ID of the database security group — for consumption by the compute layer"
  value       = aws_security_group.db.id
}
