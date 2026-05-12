provider "aws" {
  region = var.region
}

terraform {
  required_version = ">= 1.6.0"

    required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.73.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
  
  }

  backend "s3" {
    bucket         = "my-project-terraform-state-prod-1224"
    key            = "ecs/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "my-project-terraform-lock"
    encrypt        = true
  }
}