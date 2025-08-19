# Terraform Backend Configuration
# S3 bucket for state storage: terraform-policyit-seo-page
# This bucket should be created manually before running terraform init

terraform {
  backend "s3" {
    bucket = "terraform-policyit-seo-page"
    key    = "seo-page/terraform.tfstate"
    region = "us-east-1"
    # Recommended: Enable encryption and versioning in your S3 bucket
    encrypt = true
  }
}
