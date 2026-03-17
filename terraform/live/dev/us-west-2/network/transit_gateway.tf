resource "aws_ec2_transit_gateway" "this" {
  description = "Transit Gateway for ${var.region}"
  default_route_table_association = "disable"
  tags = merge(local.common_tags, { Name = "${var.environment}-transit-gateway" })
}