#App endpoints 
resource "aws_vpc_endpoint" "app_ssm" {
  vpc_id            = module.app_vpc.vpc_id
  service_name      = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids = module.app_vpc.subnet_ids
  security_group_ids = [ aws_security_group.app_endpoint_sg.id] 
  private_dns_enabled = true
  tags = merge(local.common_tags,{Name = "app-ssm-endpoint"})
}

resource "aws_vpc_endpoint" "app_ssm_messages" {
  vpc_id            = module.app_vpc.vpc_id
  service_name      = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids = module.app_vpc.subnet_ids
  security_group_ids = [ aws_security_group.app_endpoint_sg.id] 
  private_dns_enabled = true
  tags = merge(local.common_tags,{Name = "app-ssm-messages-endpoint"})
}

resource "aws_vpc_endpoint" "app_ssm_ec2messages" {
  vpc_id            = module.app_vpc.vpc_id
  service_name      = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids = module.app_vpc.subnet_ids
  security_group_ids = [ aws_security_group.app_endpoint_sg.id] 
  private_dns_enabled = true
  tags = merge(local.common_tags,{Name = "app-ec2messages-endpoint"})
}

#Ingress endpoints
resource "aws_vpc_endpoint" "ingress_ssm" {
  vpc_id            = module.ingress_vpc.vpc_id
  service_name      = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids = module.ingress_vpc.subnet_ids
  security_group_ids = [ aws_security_group.ingress_endpoint_sg.id] 
  private_dns_enabled = true
  tags = merge(local.common_tags,{Name = "ingress-ssm-endpoint"})
}

resource "aws_vpc_endpoint" "ingress_ssm_messages" {
  vpc_id            = module.ingress_vpc.vpc_id
  service_name      = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids = module.ingress_vpc.subnet_ids
  security_group_ids = [ aws_security_group.ingress_endpoint_sg.id] 
  private_dns_enabled = true 
  tags = merge(local.common_tags,{Name = "ingress-ssm-messages-endpoint"})
}

resource "aws_vpc_endpoint" "ingress_ssm_ec2messages" {
  vpc_id            = module.ingress_vpc.vpc_id
  service_name      = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids = module.ingress_vpc.subnet_ids
  security_group_ids = [ aws_security_group.ingress_endpoint_sg.id] 
  private_dns_enabled = true
  tags = merge(local.common_tags,{Name = "ingress-ec2messages-endpoint"})
}