#App endpoints (centralized — serves App and Ingress VPCs via TGW)
resource "aws_vpc_endpoint" "app_ssm" {
  vpc_id              = module.app_vpc.vpc_id
  service_name        = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [module.app_vpc.subnet_ids[0]]
  security_group_ids  = [aws_security_group.app_endpoint_sg.id]
  private_dns_enabled = true
  tags                = merge(local.common_tags, { Name = "app-ssm-endpoint" })
}

resource "aws_vpc_endpoint" "app_ssm_messages" {
  vpc_id              = module.app_vpc.vpc_id
  service_name        = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [module.app_vpc.subnet_ids[0]]
  security_group_ids  = [aws_security_group.app_endpoint_sg.id]
  private_dns_enabled = true
  tags                = merge(local.common_tags, { Name = "app-ssm-messages-endpoint" })
}

resource "aws_vpc_endpoint" "app_ssm_ec2messages" {
  vpc_id              = module.app_vpc.vpc_id
  service_name        = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [module.app_vpc.subnet_ids[0]]
  security_group_ids  = [aws_security_group.app_endpoint_sg.id]
  private_dns_enabled = true
  tags                = merge(local.common_tags, { Name = "app-ec2messages-endpoint" })
}