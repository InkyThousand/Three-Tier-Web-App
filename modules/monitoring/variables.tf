variable "environment" {
  description = "Environment name"
  type        = string
}

variable "ecs_cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "ecs_service_name" {
  description = "ECS service name"
  type        = string
}

variable "rds_identifier" {
  description = "RDS instance identifier"
  type        = string
}

variable "alarm_email" {
  description = "Email address to receive alarm notifications"
  type        = string
}

variable "ecs_cpu_threshold" {
  description = "ECS CPU utilization alarm threshold (percent)"
  type        = number
  default     = 80
}

variable "ecs_memory_threshold" {
  description = "ECS memory utilization alarm threshold (percent)"
  type        = number
  default     = 80
}

variable "rds_connections_threshold" {
  description = "RDS database connections alarm threshold"
  type        = number
  default     = 100
}
