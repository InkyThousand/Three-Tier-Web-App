# Setup Instructions

## Prerequisites
- AWS CLI configured with appropriate permissions
- Docker installed
- Terraform installed

## Quick Start

1. **Clone and deploy infrastructure:**
   ```bash
   git clone <your-repo>
   cd ThreeTierApp
   terraform init
   terraform apply -var="db_password=YourSecurePassword123"
   ```

2. **Get ECR repository URL:**
   ```bash
   terraform output ecr_repository_url
   ```

3. **Build and push initial image:**
   ```bash
   # Login to ECR
   aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $(terraform output -raw ecr_repository_url | cut -d'/' -f1)
   
   # Build and push
   docker build -t three-tier-app .
   docker tag three-tier-app:latest $(terraform output -raw ecr_repository_url):latest
   docker push $(terraform output -raw ecr_repository_url):latest
   ```

4. **Access application:**
   ```bash
   echo "Application URL: $(terraform output -raw application_url)"
   ```

## Automated Deployments

Set up GitHub Actions secrets:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

After setup, every push to main branch automatically builds and deploys your application.

## Clean Up
```bash
terraform destroy -var="db_password=YourSecurePassword123"
```
