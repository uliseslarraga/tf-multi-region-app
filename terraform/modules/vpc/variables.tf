variable "region" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "cidr_block" {
  type = string
  
}

variable "environment" {
  type = string
}

variable "az_subnets_number" {
  type = number
  default = 3
}

variable "tags" {
  type = map(string)
}