module "main_vpc" {
    source = "../../../../modules/vpc"
    
    region            = var.region
    vpc_name          = local.name_prefix
    cidr_block        = local.cidr_block
    environment       = var.environment
    tags = local.common_tags
}