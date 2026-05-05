output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_cidr_block" {
  value = aws_vpc.this.cidr_block
}

output "ingress_subnet_ids" {
  value = aws_subnet.ingress[*].id
}

output "ingress_cidr_blocks" {
  value = aws_subnet.ingress[*].cidr_block
}

output "app_subnet_ids" {
  value = aws_subnet.app[*].id
}

output "app_cidr_blocks" {
  value = aws_subnet.app[*].cidr_block
}

output "data_subnet_ids" {
  value = aws_subnet.data[*].id
}

output "data_cidr_blocks" {
  value = aws_subnet.data[*].cidr_block
}