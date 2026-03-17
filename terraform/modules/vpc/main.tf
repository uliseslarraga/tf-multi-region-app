resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = merge(var.tags, { Name = "${var.vpc_name}-vpc"})
}

resource "aws_subnet" "this" {
  count = var.az_subnets_number

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.cidr_block, 4, count.index)
  availability_zone = "${var.region}${element(["a", "b", "c"], count.index)}"

  tags = merge(var.tags, { Name = "${var.vpc_name}-subnet-${count.index}" })
  
}