# Input Variables for PolicyIT SEO Page Infrastructure

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (e.g., prod, staging, dev)"
  type        = string
  default     = "test"
}

variable "domain_name" {
  description = "Primary domain name for the website"
  type        = string
  default     = "policyittest.com"
}

variable "website_bucket_name" {
  description = "Name for the S3 bucket hosting the static website"
  type        = string
  default     = "policyittest-seo-website"
}

variable "cloudfront_price_class" {
  description = "CloudFront distribution price class"
  type        = string
  default     = "PriceClass_100"
  validation {
    condition = contains([
      "PriceClass_All",
      "PriceClass_200", 
      "PriceClass_100"
    ], var.cloudfront_price_class)
    error_message = "Price class must be PriceClass_All, PriceClass_200, or PriceClass_100."
  }
}

