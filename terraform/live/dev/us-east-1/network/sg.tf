resource "aws_security_group" "app_endpoint_sg" {
  name        = "app-endpoint-sg"
  description = "Security group for app VPC endpoints"
  vpc_id      = module.app_vpc.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.app_vpc.vpc_cidr_block, module.ingress_vpc.vpc_cidr_block]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.app_vpc.vpc_cidr_block, module.ingress_vpc.vpc_cidr_block]
  }

  tags = merge(local.common_tags, { Name = "app-endpoint-sg" })
}