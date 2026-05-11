output "screenshots_bucket_name" {
  description = "Name of the screenshots S3 bucket — for consumption by the compute layer"
  value       = module.screenshots.bucket_name
}

output "screenshots_bucket_arn" {
  description = "ARN of the screenshots S3 bucket — for consumption by the compute layer"
  value       = module.screenshots.bucket_arn
}

output "screenshots_bucket_domain_name" {
  description = "Domain name of the screenshots S3 bucket"
  value       = module.screenshots.bucket_domain_name
}
