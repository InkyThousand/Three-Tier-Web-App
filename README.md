# 3-Tier Application Infrastructure

A complete AWS 3-tier web application infrastructure built with Terraform, featuring high availability, auto-scaling, and security best practices.

## Architecture Overview

### Tier 1: Web Layer (Load Balancer)
- **Application Load Balancer (ALB)** in public subnets
- Handles incoming HTTP traffic from the internet
- Distributes requests across multiple application servers
- Health checks ensure traffic only goes to healthy instances

### Tier 2: Application Layer (Web Servers)
- **Auto Scaling Group** with EC2 instances in private subnets
- Runs Apache web servers on Amazon Linux 2
- Scales between 2-6 instances based on demand
- Only accessible through the load balancer

### Tier 3: Database Layer (RDS)
- **MySQL RDS instance** in private database subnets
- Encrypted storage with automated backups
- Only accessible from application servers
- Multi-AZ deployment for high availability

## Infrastructure Components

- **VPC**: Custom network (10.0.0.0/16) with public and private subnets
- **Security Groups**: Firewall rules controlling traffic between tiers
- **NAT Gateway**: Allows private instances to access the internet for updates
- **Internet Gateway**: Provides internet access to public subnets

## Deployment

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Plan deployment**:
   ```bash
   terraform plan -var="db_password=YourSecurePassword123"
   ```

3. **Deploy infrastructure**:
   ```bash
   terraform apply -var="db_password=YourSecurePassword123"
   ```

4. **Access application**:
   ```bash
   terraform output application_url
   ```

## Security Features

- **Network Isolation**: Each tier in separate subnets
- **Security Groups**: Restrictive firewall rules
- **Private Subnets**: App and DB tiers not directly accessible from internet
- **Encrypted Storage**: RDS encryption at rest
- **No Hardcoded Secrets**: Database password passed as variable

## Cost Optimization

- **t3.micro instances**: Cost-effective for development/testing
- **Auto Scaling**: Only pay for instances you need
- **Single NAT Gateway**: Reduces NAT costs (consider Multi-AZ for production)

## Clean Up

To avoid ongoing charges:
```bash
terraform destroy -var="db_password=YourSecurePassword123"
```

## File Structure

```
├── main.tf                 # Root module configuration
├── variables.tf            # Input variables
├── outputs.tf             # Output values
├── providers.tf           # Provider configuration
└── modules/
    ├── vpc/               # VPC and networking
    ├── security_groups/   # Security group rules
    ├── alb/              # Application Load Balancer
    ├── asg_app/          # Auto Scaling Group
    └── rds/              # RDS Database
```