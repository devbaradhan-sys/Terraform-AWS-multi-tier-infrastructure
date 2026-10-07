# Terraform AWS Multi-Tier Infrastructure

Infrastructure as Code project using Terraform to provision AWS resources.

## Version 1

The first version provisions an AWS EC2 instance using Terraform.

### Technologies

- Terraform
- AWS
- EC2
- Linux
- Apache HTTP Server

### Current Architecture

Developer
   |
   | Terraform
   v
AWS
   |
   └── EC2
       └── Apache HTTP Server

## What I Learned

- Terraform provider configuration
- Terraform resources
- Terraform variables and arguments
- `terraform init`
- `terraform plan`
- `terraform apply`
- AWS authentication using AWS CLI
- EC2 provisioning using Terraform
- EC2 user data

## Future Improvements

- VPC and subnet configuration
- Security groups
- IAM roles
- Load Balancer
- Auto Scaling
- RDS
- Terraform modules
- Remote state
- Multiple environments
- CI/CD