resource "aws_route_table" "ingress" {
  vpc_id = module.ingress_vpc.vpc_id
  route {
    cidr_block = module.app_vpc.vpc_cidr_block
    transit_gateway_id = aws_ec2_transit_gateway.this.id
  }
}

resource "aws_route_table" "app" {
  vpc_id = module.app_vpc.vpc_id
  route {
    cidr_block = module.ingress_vpc.vpc_cidr_block
    transit_gateway_id = aws_ec2_transit_gateway.this.id
  }
  route {
    cidr_block = module.data_vpc.vpc_cidr_block
    transit_gateway_id = aws_ec2_transit_gateway.this.id
  }
}

resource "aws_route_table" "data" {
  vpc_id = module.data_vpc.vpc_id
  route {
    cidr_block = module.app_vpc.vpc_cidr_block
    transit_gateway_id = aws_ec2_transit_gateway.this.id
  }
}

#Route tables associaton for subnets
resource "aws_main_route_table_association" "ingress" {
  vpc_id         = module.ingress_vpc.vpc_id
  route_table_id = aws_route_table.ingress.id
}

resource "aws_main_route_table_association" "app" {
  vpc_id         = module.app_vpc.vpc_id
  route_table_id = aws_route_table.app.id
}

resource "aws_main_route_table_association" "data" {
  vpc_id         = module.data_vpc.vpc_id
  route_table_id = aws_route_table.data.id
}