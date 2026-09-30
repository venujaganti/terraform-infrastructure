output "distribution_id" {
  description = "CloudFront distribution ID."
  value       = aws_cloudfront_distribution.this.id
}

output "distribution_arn" {
  description = "CloudFront distribution ARN."
  value       = aws_cloudfront_distribution.this.arn
}

output "distribution_domain_name" {
  description = "CloudFront distribution domain name."
  value       = aws_cloudfront_distribution.this.domain_name
}

output "hosted_zone_id" {
  description = "CloudFront Route 53 hosted zone ID."
  value       = aws_cloudfront_distribution.this.hosted_zone_id
}

output "status" {
  description = "CloudFront distribution status."
  value       = aws_cloudfront_distribution.this.status
}

output "enabled" {
  description = "Whether the CloudFront distribution is enabled."
  value       = aws_cloudfront_distribution.this.enabled
}