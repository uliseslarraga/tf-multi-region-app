resource "aws_route_table" "ingress" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "app" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "data" {
  vpc_id = aws_vpc.this.id
}

#Route tables associaton for subnets
resource "aws_route_table_association" "ingress" {
  count          = var.az_subnets_number
  subnet_id      = aws_subnet.ingress[count.index].id
  route_table_id = aws_route_table.ingress.id
}

resource "aws_route_table_association" "app" {
  count          = var.az_subnets_number
  subnet_id      = aws_subnet.app[count.index].id
  route_table_id = aws_route_table.app.id
}

resource "aws_route_table_association" "data" {
  count          = var.az_subnets_number
  subnet_id      = aws_subnet.data[count.index].id
  route_table_id = aws_route_table.data.id
}