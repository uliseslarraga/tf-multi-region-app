locals {
  region_short = {
    "us-east-1" = "use1"
    "us-west-2" = "usw2"
  }[var.region]

  name_prefix = "${var.project}-${var.environment}-${local.region_short}"

  common_tags = {
    Project     = var.project
    Environment = var.environment
    Region      = var.region
    ManagedBy   = "terraform"
  }

  cidr_block = cidrsubnet(var.cidr, 2, 0)
}
