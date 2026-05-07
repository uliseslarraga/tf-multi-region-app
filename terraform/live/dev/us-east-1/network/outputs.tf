output "main_vpc" {
  description = "ID of the single regional VPC"
  value       = module.main_vpc.vpc_id
}

output "app_subnets" {
  description = "Subnet IDs for the App tier, one per AZ (a/b/c)"
  value       = module.main_vpc.app_subnet_ids
}

output "data_subnets" {
  description = "Subnet IDs for the Data tier, one per AZ (a/b/c)"
  value       = module.main_vpc.data_subnet_ids
}