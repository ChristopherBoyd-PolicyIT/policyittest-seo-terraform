terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "PolicyIT-Test"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Repository  = "PolicyIT/policyittest-seo-terraform"
    }
  }
}

# Provider for us-east-1 (required for ACM certificates used with CloudFront)
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"

  default_tags {
    tags = {
      Project     = "PolicyIT-Test"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Repository  = "PolicyIT/policyittest-seo-terraform"
    }
  }
}
