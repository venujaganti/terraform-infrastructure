output "bucket_id" {
  description = "ID/name of the S3 bucket."
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket."
  value       = aws_s3_bucket.this.arn
}

output "bucket_name" {
  description = "Name of the S3 bucket."
  value       = aws_s3_bucket.this.bucket
}

output "bucket_domain_name" {
  description = "Regional domain name of the S3 bucket."
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}

output "bucket_region" {
  description = "AWS region where the S3 bucket is located."
  value       = aws_s3_bucket.this.region
}