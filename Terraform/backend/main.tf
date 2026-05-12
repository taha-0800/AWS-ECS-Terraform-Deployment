terraform {
  required_version = ">= 1.6.0, < 2.0.0" 

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.35.0" 
    }
  }
}

provider "aws" {
  region = var.region
}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0" 

  bucket        = "${var.project_name}-terraform-state-${var.environment}-1224"
  acl           = null
  force_destroy = true

  versioning = {
    enabled = true
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

module "dynamodb_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "~> 2.0" 

  name         = "${var.project_name}-terraform-lock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attributes = [
    {
      name = "LockID"
      type = "S"
    }
  ]

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}


 
 





