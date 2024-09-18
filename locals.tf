locals {
  name = "${var.stack}-${var.environment}"
  environment = var.environment
  stack = var.stack

  common_tags = {
    environment = local.environment
    stack = local.stack
  }
}