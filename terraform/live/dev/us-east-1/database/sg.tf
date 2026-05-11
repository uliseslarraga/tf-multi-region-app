data "aws_subnet" "app" {
  for_each = toset(data.terraform_remote_state.network.outputs.app_subnets)
  id       = each.value
}

resource "aws_security_group" "db" {
  name        = "${local.name_prefix}-db-sg"
  description = "Allow PostgreSQL access from app tier"
  vpc_id      = data.terraform_remote_state.network.outputs.main_vpc

  ingress {
    description = "PostgreSQL from app tier"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [for s in data.aws_subnet.app : s.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "${local.name_prefix}-db-sg" })
}
