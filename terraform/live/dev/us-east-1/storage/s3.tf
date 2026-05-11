data "terraform_remote_state" "storage_usw2" {
  count = var.enable_replication ? 1 : 0

  backend = "s3"
  config = {
    profile = "default"
    bucket  = "tf-backend-bucket-culr-03-2026"
    key     = "live/dev/us-west-2/storage/terraform.tfstate"
    region  = "us-east-1"
  }
}

module "screenshots" {
  source = "../../../../modules/s3"

  name_prefix                        = local.name_prefix
  environment                        = var.environment
  force_destroy                      = var.force_destroy
  replication_destination_bucket_arn = var.enable_replication ? data.terraform_remote_state.storage_usw2[0].outputs.screenshots_bucket_arn : ""
  common_tags                        = local.common_tags
}
