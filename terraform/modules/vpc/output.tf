output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_cidr_block" {
  value = aws_vpc.this.cidr_block
}

output "subnet_ids" {
  value = aws_subnet.this.*.id
}

output "subnet_cidr_blocks" {
  value = aws_subnet.this.*.cidr_block
}