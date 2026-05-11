locals {
  region_short = {
    "us-east-1" = "use1"
    "us-west-2" = "usw2"
  }[var.aws_region]

  name_prefix = "${var.project}-${var.environment}-${local.region_short}"

  common_tags = {
    Project     = var.project
    Environment = var.environment
    Region      = var.aws_region
    ManagedBy   = "terraform"
  }
}
