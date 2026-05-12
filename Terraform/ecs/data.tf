data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "my-project-terraform-state-prod-1224"
    key    = "networking/terraform.tfstate"
    region = "us-east-1"
  }
}