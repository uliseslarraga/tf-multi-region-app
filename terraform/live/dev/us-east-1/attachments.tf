resource "aws_ec2_transit_gateway_vpc_attachment" "ingress" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = module.ingress_vpc.vpc_id
  subnet_ids         = module.ingress_vpc.subnet_ids
  tags               = merge(local.common_tags, { Name = "${var.environment}-ingress-attachment" })
}

resource "aws_ec2_transit_gateway_vpc_attachment" "app" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = module.app_vpc.vpc_id
  subnet_ids         = module.app_vpc.subnet_ids
  tags               = merge(local.common_tags, { Name = "${var.environment}-app-attachment" })
}

resource "aws_ec2_transit_gateway_vpc_attachment" "data" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = module.data_vpc.vpc_id
  subnet_ids         = module.data_vpc.subnet_ids
  tags               = merge(local.common_tags, { Name = "${var.environment}-data-attachment" })
}