output "ingress_vpc" {
  value = module.ingress_vpc.vpc_id
}

output "ingress_subnets" {
  value = module.ingress_vpc.subnet_ids
}

output "app_vpc" {
  value = module.app_vpc.vpc_id
}

output "app_subnets" {
  value = module.app_vpc.subnet_ids
}

output "data_vpc" {
  value = module.data_vpc.vpc_id
}

output "data_subnets" {
    value = module.data_vpc.subnet_ids
}