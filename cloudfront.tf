# CloudFront Distribution for Global CDN and SSL

# SSL Certificate for the domain (must be in us-east-1 for CloudFront)
resource "aws_acm_certificate" "website" {
  provider          = aws.us_east_1
  domain_name       = var.domain_name
  subject_alternative_names = ["www.${var.domain_name}"]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# CloudFront distribution
resource "aws_cloudfront_distribution" "website" {
  origin {
    domain_name              = aws_s3_bucket.website.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.website.id
    origin_id                = "S3-${var.website_bucket_name}"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "PolicyIT Test website distribution"
  default_root_object = "index.html"

  # Aliases for the distribution - temporarily disabled until DNS is delegated
  # aliases = [var.domain_name, "www.${var.domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.website_bucket_name}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  # Cache behavior for static assets
  ordered_cache_behavior {
    path_pattern     = "/assets/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "S3-${var.website_bucket_name}"

    forwarded_values {
      query_string = false
      headers      = ["Origin"]
      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = var.cloudfront_price_class

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    # Temporarily use CloudFront default certificate until DNS is delegated
    cloudfront_default_certificate = true
    # acm_certificate_arn      = aws_acm_certificate_validation.website.certificate_arn
    # ssl_support_method       = "sni-only"
    # minimum_protocol_version = "TLSv1.2_2021"
  }

  custom_error_response {
    error_code         = 404
    response_code      = 404
    response_page_path = "/error.html"
  }

  custom_error_response {
    error_code         = 403
    response_code      = 404
    response_page_path = "/error.html"
  }

  # Temporarily remove dependency on certificate validation
  # depends_on = [aws_acm_certificate_validation.website]
}

# Certificate validation - temporarily disabled until DNS is delegated
# resource "aws_acm_certificate_validation" "website" {
#   provider        = aws.us_east_1
#   certificate_arn = aws_acm_certificate.website.arn
#   validation_record_fqdns = [
#     for record in aws_route53_record.cert_validation : record.fqdn
#   ]

#   timeouts {
#     create = "10m"
#   }
# }
