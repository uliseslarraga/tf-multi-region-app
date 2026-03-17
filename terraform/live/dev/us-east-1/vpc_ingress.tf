module "ingress_vpc" {
    source = "../../../modules/vpc"
    
    region            = var.region
    vpc_name          = "ingress"
    cidr_block        = local.cidr_blocks.ingress
    environment       = var.environment
    tags              = local.common_tags
}