#Route tables for the transit gateway
resource "aws_ec2_transit_gateway_route_table" "ingress" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  tags = merge(local.common_tags, { Name = "${var.environment}-ingress-route-table" })
}

resource "aws_ec2_transit_gateway_route_table" "core" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  tags = merge(local.common_tags, { Name = "${var.environment}-core-route-table" })
}

#Route table associations for VPC attachments
resource "aws_ec2_transit_gateway_route_table_association" "ingress" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.ingress.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.ingress.id
}

resource "aws_ec2_transit_gateway_route_table_association" "app" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.app.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.core.id
}

resource "aws_ec2_transit_gateway_route_table_association" "data" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.data.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.core.id
}

#TGW routes for VPC attachments
resource "aws_ec2_transit_gateway_route" "ingress_to_app" {
  destination_cidr_block         = module.app_vpc.vpc_cidr_block
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.app.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.ingress.id
}

resource "aws_ec2_transit_gateway_route" "core_to_ingress" {
  destination_cidr_block         = module.ingress_vpc.vpc_cidr_block
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.ingress.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.core.id
}

resource "aws_ec2_transit_gateway_route" "app_to_data" {
  destination_cidr_block         = module.data_vpc.vpc_cidr_block
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.data.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.core.id
}

resource "aws_ec2_transit_gateway_route" "data_to_app" {
  destination_cidr_block         = module.app_vpc.vpc_cidr_block
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.app.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.core.id
}

#propagate default routes to attachments
resource "aws_ec2_transit_gateway_route_table_propagation" "ingress" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.ingress.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.ingress.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "app" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.app.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.core.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "data" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.data.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.core.id
}