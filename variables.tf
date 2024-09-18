variable "aws_region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "The environment to deploy the resources"
  type        = string
  default     = "dev"
}

variable "stack" {
  description = "The stack to deploy the resources"
  type        = string
  default     = "laboratorio"
}

