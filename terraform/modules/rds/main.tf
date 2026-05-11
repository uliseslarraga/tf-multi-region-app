locals {
  pg_family = "postgres${split(".", var.engine_version)[0]}"
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.name_prefix}-postgres-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-postgres-subnet-group"
  })
}

resource "aws_db_parameter_group" "this" {
  name   = "${var.name_prefix}-postgres-pg"
  family = local.pg_family

  parameter {
    name  = "rds.force_ssl"
    value = "1"
  }

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-postgres-pg"
  })
}

resource "aws_db_instance" "primary" {
  identifier     = "${var.name_prefix}-postgres-primary"
  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class

  db_name  = var.db_name
  username = var.username
  password = var.password

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = var.storage_encrypted

  db_subnet_group_name   = aws_db_subnet_group.this.name
  parameter_group_name   = aws_db_parameter_group.this.name
  vpc_security_group_ids = var.vpc_security_group_ids

  multi_az                    = var.multi_az
  backup_retention_period     = var.backup_retention_period
  auto_minor_version_upgrade  = true
  allow_major_version_upgrade = true
  deletion_protection         = var.deletion_protection
  skip_final_snapshot         = var.skip_final_snapshot

  # Enables zero-downtime version upgrades and schema changes via AWS Blue/Green Deployments.
  # Requires multi_az = true and backup_retention_period > 0.
  blue_green_update {
    enabled = true
  }

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-postgres-primary"
  })
}
