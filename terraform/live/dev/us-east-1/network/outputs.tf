output "main_vpc" {
  value = module.main_vpc.vpc_id
}

output "app_subnets" {
  value = module.main_vpc.app_subnet_ids
}

output "data_subnets" {
    value = module.main_vpc.data_subnet_ids
}