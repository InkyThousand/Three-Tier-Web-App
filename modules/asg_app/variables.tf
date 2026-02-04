variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs of private subnets for app servers"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for app servers"
  type        = string
}

variable "target_group_arn" {
  description = "ALB target group ARN"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}