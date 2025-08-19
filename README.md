# PolicyIT SEO Page Infrastructure

This repository contains the Terraform infrastructure code for the PolicyIT SEO static website hosted on AWS.

## Architecture

The infrastructure includes:

- **S3 Static Website**: Secure S3 bucket for hosting static web content
- **CloudFront CDN**: Global content delivery network with SSL/TLS termination
- **ACM Certificate**: SSL certificate for HTTPS (auto-renewed)
- **Route53 DNS**: DNS management (optional, for when migrating from Porkbun)

## Prerequisites

1. **AWS CLI configured** with appropriate permissions
2. **Terraform >= 1.0** installed
3. **S3 Backend Bucket** created manually (see setup instructions below)
4. **GitHub OIDC Role** from the shared resources repository

## Initial Setup

### 1. Created S3 Backend Bucket outside of TF


### 2. Configure Variables

Copy the example variables file and customize:

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your specific values
```

### 3. Initialize and Deploy

```bash
# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Apply the infrastructure
terraform apply
```

## Configuration

### Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `aws_region` | AWS region for resources | `us-east-1` | No |
| `environment` | Environment name | `prod` | No |
| `domain_name` | Primary domain name | `policyit.com` | No |
| `website_bucket_name` | S3 bucket name for website | `policyit-seo-website` | No |
| `cloudfront_price_class` | CloudFront price class | `PriceClass_100` | No |
| `enable_route53` | Create Route53 hosted zone | `false` | No |

### DNS Configuration

#### Current Setup (Porkbun DNS)

Since your domain is currently managed by Porkbun, set `enable_route53 = false` in your `terraform.tfvars`. After deployment, you'll need to:

1. **Get the CloudFront domain name** from Terraform outputs
2. **Create a CNAME record** in Porkbun pointing `policyit.com` to the CloudFront domain
3. **Create a CNAME record** for `www.policyit.com` pointing to the same CloudFront domain

#### Future Migration to Route53

When ready to migrate DNS to AWS:

1. Set `enable_route53 = true` in `terraform.tfvars`
2. Run `terraform apply`
3. Update your domain's name servers at Porkbun to use the Route53 name servers (from Terraform outputs)

## GitHub Actions Workflows

### Terraform Workflow (`terraform.yml`)

Runs on pushes to `main` and pull requests:

- **Format Check**: Ensures code formatting
- **Validation**: Validates Terraform syntax
- **Plan**: Shows what changes will be made
- **Apply**: Applies changes on merge to main
- **PR Comments**: Posts plan results to pull requests

### Validation Workflow (`terraform-validate.yml`)

Runs on feature branches:

- **Format Check**: Code formatting validation
- **Syntax Validation**: Terraform syntax check
- **No AWS Access**: Runs without AWS credentials for security

### Setup GitHub Actions

1. **Add Repository Secret**:
   - Go to repository Settings → Secrets and variables → Actions
   - Add secret: `AWS_ROLE_ARN` = `arn:aws:iam::940482434177:role/policyit-github-actions-role`

2. **Workflows will automatically**:
   - Validate code on PRs
   - Deploy infrastructure on merge to main
   - Use secure OIDC authentication

## Outputs

After deployment, Terraform provides these outputs:

- `website_bucket_name`: S3 bucket name for uploading content
- `cloudfront_domain_name`: CloudFront distribution domain
- `website_url`: Final website URL
- `certificate_arn`: SSL certificate ARN
- `route53_name_servers`: Name servers for DNS delegation (if Route53 enabled)

## Website Content Deployment

Website content is deployed via the separate `policyIT-seo-webpage` repository, which:

1. Contains the HTML/CSS/JS files
2. Uses GitHub Actions to sync content to the S3 bucket
3. Invalidates CloudFront cache after deployment

## Security Features

- **S3 Bucket**: Private with CloudFront-only access
- **CloudFront**: HTTPS redirect, modern TLS versions
- **OIDC Authentication**: No stored AWS credentials in GitHub
- **Encryption**: S3 server-side encryption enabled
- **Versioning**: S3 versioning for content recovery

## Cost Optimization

- **CloudFront**: Uses `PriceClass_100` (US, Canada, Europe)
- **S3**: Standard storage class with lifecycle policies
- **Route53**: Only created when needed

## Troubleshooting

### Certificate Validation Issues

If certificate validation fails:

1. Ensure DNS records are properly configured
2. Check that domain ownership is verified
3. Certificate validation can take up to 30 minutes

### CloudFront Deployment Time

CloudFront distributions take 15-20 minutes to deploy. Be patient during initial setup.

### DNS Propagation

DNS changes can take up to 48 hours to propagate globally.

## Related Repositories

- **Shared Resources**: `PolicyIT/terraform-shared-resources` (OIDC role, shared infrastructure)
- **Website Content**: `PolicyIT/policyIT-seo-webpage` (HTML content and deployment)

## Support

For issues or questions, please create an issue in this repository or contact the PolicyIT infrastructure team.
