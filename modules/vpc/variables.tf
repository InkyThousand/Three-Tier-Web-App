variable "vpc_cidr" {

  description = "CIDR block for VPC"
  default = "10.0.0.0/16"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}