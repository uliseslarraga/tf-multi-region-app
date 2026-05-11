output "primary_instance_id" {
  description = "Identifier of the primary RDS instance"
  value       = aws_db_instance.primary.identifier
}

output "primary_instance_arn" {
  description = "ARN of the primary RDS instance"
  value       = aws_db_instance.primary.arn
}

output "primary_endpoint" {
  description = "Connection endpoint for the primary RDS instance (host:port)"
  value       = aws_db_instance.primary.endpoint
}

output "primary_address" {
  description = "Hostname of the primary RDS instance"
  value       = aws_db_instance.primary.address
}

output "primary_port" {
  description = "Port the primary RDS instance listens on"
  value       = aws_db_instance.primary.port
}

output "db_subnet_group_name" {
  description = "Name of the DB subnet group"
  value       = aws_db_subnet_group.this.name
}

output "parameter_group_name" {
  description = "Name of the DB parameter group"
  value       = aws_db_parameter_group.this.name
}
