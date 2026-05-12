

variable "region" {
  type        = string
  description = "Region to deploy resources"
}

variable "env_name_dev" {
  type        = string
  description = "Name of the environment to deploy"
}

variable "env_name_prod" {
  type        = string
  description = "Name of the environment to deploy"
}

variable "account_id" {
  type        = string
  description = "Account ID for target account"
}

variable "app_name" {
  type        = string
  description = "Application name"
  default     = "web-app"
}
