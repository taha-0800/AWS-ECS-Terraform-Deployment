output "alb_dns_name" {
  value       = aws_lb.app_alb.dns_name
  description = "The DNS name of the ALB - use this to access your app"
}

output "dev_target_group_arn" {
  value       = aws_lb_target_group.dev_target_group_1.arn
  description = "The ARN of the dev target group"
}

output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS Task Execution Role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS Task Role"
  value       = aws_iam_role.ecs_task_role.arn
}