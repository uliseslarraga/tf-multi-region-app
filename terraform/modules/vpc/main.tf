resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = merge(var.tags, { Name = "${var.vpc_name}-vpc"})
}

resource "aws_subnet" "ingress" {
  count = var.az_subnets_number

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.cidr_block, 4, count.index)
  availability_zone = "${var.region}${element(["a", "b", "c"], count.index)}"

  tags = merge(var.tags, { Name = "${var.vpc_name}-ingress-subnet-${element(["a", "b", "c"], count.index)}" })
  
}

resource "aws_subnet" "app" {
  count = var.az_subnets_number

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.cidr_block, 4, var.az_subnets_number+count.index)
  availability_zone = "${var.region}${element(["a", "b", "c"], count.index)}"

  tags = merge(var.tags, { Name = "${var.vpc_name}-app-subnet-${element(["a", "b", "c"], count.index)}" })
  
}

resource "aws_subnet" "data" {
  count = var.az_subnets_number

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.cidr_block, 4, (var.az_subnets_number*2) + count.index)
  availability_zone = "${var.region}${element(["a", "b", "c"], count.index)}"

  tags = merge(var.tags, { Name = "${var.vpc_name}-data-subnet-${element(["a", "b", "c"], count.index)}" })
  
}