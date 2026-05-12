# Automated Cloud Infrastructure Deployment Using AWS ECS and Terraform

## Overview
This project designs and implements a fully automated cloud infrastructure 
on AWS to deploy a containerised Python Flask web application. The 
application converts uploaded images to PDF format and is served across 
three simultaneous containers behind an Application Load Balancer, 
demonstrating horizontal load balancing in a real-world cloud environment.

## Architecture
- **VPC** with public and private subnets across 3 availability zones
- **Application Load Balancer** distributing traffic across 3 ECS containers
- **Amazon ECS Fargate** for serverless container orchestration
- **Amazon ECR** for versioned Docker image storage
- **Terraform IaC** split into 3 independent modules with remote state in S3

## Tech Stack
- Terraform
- Docker
- Python Flask
- AWS ECS Fargate
- AWS ALB
- AWS ECR
- AWS S3 + DynamoDB
- AWS CloudWatch
## Project Structure
├── app/
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
├── Terraform/
│   ├── backend/
│   ├── networking/
│   └── ecs/
└── README.md
## Prerequisites
- AWS CLI configured with valid credentials
- Terraform >= 1.6.0 installed
- Docker Desktop running

## Deployment

### 1. Deploy Backend
```bash
cd Terraform/backend
terraform init
terraform apply
```

### 2. Deploy Networking
```bash
cd Terraform/networking
terraform init
terraform apply
```

### 3. Deploy ECS Infrastructure
```bash
cd Terraform/ecs
terraform init
terraform apply
```

### 4. Build and Push Docker Image
```bash
cd app
docker build -t web-app .
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin YOUR_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com
docker tag web-app:latest YOUR_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/web-app-repository:main-latest
docker push YOUR_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/web-app-repository:main-latest
```

### 5. Access the Application
Get the ALB DNS name from Terraform output:
```bash
cd Terraform/ecs
terraform output alb_dns_name
```
Open in browser: `http://<alb-dns-name>.us-east-1.elb.amazonaws.com`

## Load Balancing
The ECS service runs 3 simultaneous container instances. Each container 
returns its unique hostname in the response — refresh the page multiple 
times to see different hostnames proving load balancing is working.

## Security
- ECS containers run in private subnets — unreachable directly from internet
- ALB is the only entry point on port 80
- Two separate IAM roles following least privilege principle
- Security groups restrict traffic between ALB and ECS only


## Future Improvements
- HTTPS with ACM certificate and Route53
- ECS auto scaling based on CPU utilisation
- Blue/green deployment with AWS CodeDeploy
- Kubernetes migration
