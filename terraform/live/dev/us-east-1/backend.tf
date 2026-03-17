terraform {
  backend "s3" {
    bucket         = "tf-backend-bucket-culr-03-2026"
    key            = "live/dev/us-east-1/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    use_lockfile   = true
  }
}