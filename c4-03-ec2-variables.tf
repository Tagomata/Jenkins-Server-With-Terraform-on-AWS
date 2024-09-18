variable "instance_type" {
  description = "The type of the instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use for the instance"
  type        = string
  default     = "jenkins-server"
}
