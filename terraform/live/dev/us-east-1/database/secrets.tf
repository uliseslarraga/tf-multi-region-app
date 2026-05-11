resource "aws_secretsmanager_secret" "db" {
  name                    = "${local.name_prefix}-postgres-credentials"
  description             = "RDS master credentials for ${local.name_prefix}"
  recovery_window_in_days = 7

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-postgres-credentials"
  })
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db.result
    host     = module.rds.address
    port     = module.rds.port
    dbname   = var.db_name
  })
}
