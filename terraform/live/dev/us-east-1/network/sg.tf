resource "aws_security_group" "app_endpoint_sg" {
  name        = "app-endpoint-sg"
  description = "Security group for app VPC endpoints"
  vpc_id      = module.main_vpc.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = concat(
      module.main_vpc.app_cidr_blocks,
      module.main_vpc.ingress_cidr_blocks
    )
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = concat(
      module.main_vpc.app_cidr_blocks,
      module.main_vpc.ingress_cidr_blocks
    )
  }

  tags = merge(local.common_tags, { Name = "app-endpoint-sg" })
}