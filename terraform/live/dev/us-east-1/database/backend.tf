terraform {
  backend "s3" {
    profile      = "default"
    bucket       = "tf-backend-bucket-culr-03-2026"
    key          = "live/dev/us-east-1/database/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
