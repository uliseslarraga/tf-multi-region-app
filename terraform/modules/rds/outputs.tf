output "instance_id" {
  description = "Identifier of the RDS instance"
  value       = aws_db_instance.this.identifier
}

output "instance_arn" {
  description = "ARN of the RDS instance"
  value       = aws_db_instance.this.arn
}

output "endpoint" {
  description = "Connection endpoint (host:port)"
  value       = aws_db_instance.this.endpoint
}

output "address" {
  description = "Hostname of the RDS instance"
  value       = aws_db_instance.this.address
}

output "port" {
  description = "Port the RDS instance listens on"
  value       = aws_db_instance.this.port
}

output "db_subnet_group_name" {
  description = "Name of the DB subnet group"
  value       = aws_db_subnet_group.this.name
}

output "parameter_group_name" {
  description = "Name of the DB parameter group"
  value       = aws_db_parameter_group.this.name
}
