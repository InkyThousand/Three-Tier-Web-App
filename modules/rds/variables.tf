variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs of private subnets for database"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for database"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "db_username" {
  description = "Database master username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}