resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = module.main_vpc.vpc_id
  service_name        = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [module.main_vpc.app_subnet_ids[0]]
  security_group_ids  = [aws_security_group.app_endpoint_sg.id]
  private_dns_enabled = true
  tags                = merge(local.common_tags, { Name = "${local.name_prefix}-ssm-endpoint" })
}

resource "aws_vpc_endpoint" "ssm_messages" {
  vpc_id              = module.main_vpc.vpc_id
  service_name        = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [module.main_vpc.app_subnet_ids[0]]
  security_group_ids  = [aws_security_group.app_endpoint_sg.id]
  private_dns_enabled = true
  tags                = merge(local.common_tags, { Name = "${local.name_prefix}-ssmmessages-endpoint" })
}

resource "aws_vpc_endpoint" "ssm_ec2messages" {
  vpc_id              = module.main_vpc.vpc_id
  service_name        = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [module.main_vpc.app_subnet_ids[0]]
  security_group_ids  = [aws_security_group.app_endpoint_sg.id]
  private_dns_enabled = true
  tags                = merge(local.common_tags, { Name = "${local.name_prefix}-ec2messages-endpoint" })
}