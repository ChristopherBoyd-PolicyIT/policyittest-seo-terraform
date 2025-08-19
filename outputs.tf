# Output Values for PolicyIT SEO Page Infrastructure

output "website_bucket_name" {
  description = "Name of the S3 bucket hosting the website"
  value       = aws_s3_bucket.website.id
}

output "website_bucket_arn" {
  description = "ARN of the S3 bucket hosting the website"
  value       = aws_s3_bucket.website.arn
}

output "cloudfront_distribution_id" {
  description = "ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.website.id
}

output "cloudfront_distribution_arn" {
  description = "ARN of the CloudFront distribution"
  value       = aws_cloudfront_distribution.website.arn
}

output "cloudfront_domain_name" {
  description = "Domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.website.domain_name
}

output "website_url" {
  description = "URL of the website"
  value       = "https://${var.domain_name}"
}

output "certificate_arn" {
  description = "ARN of the SSL certificate"
  value       = aws_acm_certificate.website.arn
}

output "route53_zone_id" {
  description = "Route53 hosted zone ID"
  value       = aws_route53_zone.website.zone_id
}

output "route53_name_servers" {
  description = "Route53 name servers - use these to delegate DNS from Porkbun"
  value       = aws_route53_zone.website.name_servers
}

output "certificate_validation_records" {
  description = "Certificate validation DNS records created in Route53"
  value = {
    for record in aws_route53_record.cert_validation : record.name => {
      name    = record.name
      type    = record.type
      records = record.records
      ttl     = record.ttl
    }
  }
}

# Temporarily disabled - certificate validation not working until DNS is delegated
# output "certificate_status" {
#   description = "ACM certificate status and validation details"
#   value = {
#     arn    = aws_acm_certificate.website.arn
#     status = aws_acm_certificate.website.status
#     domain_validation_options = aws_acm_certificate.website.domain_validation_options
#   }
# }
