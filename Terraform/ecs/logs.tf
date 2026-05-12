# CloudWatch Log Group for dev environment
resource "aws_cloudwatch_log_group" "dev_log_group" {
  name              = "/ecs/web-app-dev"
  retention_in_days = 180 # 6 months retention

  tags = {
    Environment = var.env_name_dev
    Project     = var.app_name
  }
}


