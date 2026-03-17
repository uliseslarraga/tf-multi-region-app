module "data_vpc" {
    source = "../../../modules/vpc"
    
    region            = var.region
    vpc_name          = "data"
    cidr_block        = local.cidr_blocks.data
    environment       = var.environment
    tags = local.common_tags
}