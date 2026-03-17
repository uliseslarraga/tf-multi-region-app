module "app_vpc" {
    source = "../../../modules/vpc"
    
    region            = var.region
    vpc_name          = "app"
    cidr_block        = local.cidr_blocks.app
    environment       = var.environment
    tags = local.common_tags
}