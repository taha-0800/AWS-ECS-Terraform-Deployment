###############################
# Application Load Balancer
###############################

resource "aws_lb" "app_alb" {
  name               = "${var.app_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.sg_alb.security_group_id]
  subnets            = local.public_subnets

  enable_deletion_protection = false

  tags = {
    Project = var.app_name
  }
}

###############################
# HTTP Listener
###############################

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  # Default forward to first dev target group
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dev_target_group_1.arn
  }
}

###############################
# Dev Target Groups
###############################

# Target Group 1
resource "aws_lb_target_group" "dev_target_group_1" {
  name        = "${var.app_name}-dev-tg-1"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = local.vpc.vpc_id

  health_check {
    path                = "/api/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Environment = var.env_name_dev
    Project     = var.app_name
  }
}

