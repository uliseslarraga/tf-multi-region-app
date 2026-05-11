output "bucket_id" {
  description = "Name (ID) of the S3 bucket"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.this.arn
}

output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.this.bucket
}

output "bucket_domain_name" {
  description = "Bucket domain name (e.g. bucket.s3.amazonaws.com)"
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "replication_role_arn" {
  description = "ARN of the IAM replication role; empty string when replication is disabled"
  value       = local.enable_replication ? aws_iam_role.replication[0].arn : ""
}
