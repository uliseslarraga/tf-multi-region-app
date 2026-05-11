resource "random_password" "db" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "tf-backend-bucket-culr-03-2026"
    key    = "live/dev/us-east-1/network/terraform.tfstate"
    region = "us-east-1"
  }
}

module "rds" {
  source = "../../../../modules/rds"

  name_prefix            = local.name_prefix
  subnet_ids             = data.terraform_remote_state.network.outputs.data_subnets
  vpc_security_group_ids = [aws_security_group.db.id]
  db_name                = var.db_name
  username               = var.db_username
  password               = random_password.db.result
  instance_class         = var.instance_class
common_tags            = local.common_tags
}
