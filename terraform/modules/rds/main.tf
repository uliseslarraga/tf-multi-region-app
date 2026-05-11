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

resource "aws_db_instance" "this" {
  identifier     = "${var.name_prefix}-postgres-primary"
  instance_class = var.instance_class

  # Replica inherits engine, credentials, and storage from the source DB.
  # Setting these to null when is_failover = true avoids conflicts with replicate_source_db.
  replicate_source_db   = var.is_failover ? var.source_db_arn : null
  engine                = var.is_failover ? null : "postgres"
  engine_version        = var.is_failover ? null : var.engine_version
  db_name               = var.is_failover ? null : var.db_name
  username              = var.is_failover ? null : var.username
  password              = var.is_failover ? null : var.password
  allocated_storage     = var.is_failover ? null : var.allocated_storage
  max_allocated_storage = var.is_failover ? null : var.max_allocated_storage
  storage_type          = var.is_failover ? null : var.storage_type
  storage_encrypted     = var.is_failover ? null : var.storage_encrypted
  multi_az              = var.is_failover ? null : var.multi_az
  backup_retention_period = var.is_failover ? null : var.backup_retention_period

  db_subnet_group_name   = aws_db_subnet_group.this.name
  parameter_group_name   = aws_db_parameter_group.this.name
  vpc_security_group_ids = var.vpc_security_group_ids

  auto_minor_version_upgrade  = true
  allow_major_version_upgrade = true
  deletion_protection         = var.deletion_protection
  skip_final_snapshot         = var.skip_final_snapshot

  # blue_green_update requires multi_az and backup_retention_period > 0; not supported on replicas.
  dynamic "blue_green_update" {
    for_each = var.is_failover ? [] : [1]
    content {
      enabled = true
    }
  }

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-postgres-primary"
  })
}
