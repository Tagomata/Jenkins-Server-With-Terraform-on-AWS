module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name = local.name
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  enable_nat_gateway = var.enable_nat_gateway

  tags = local.common_tags

  vpc_tags = {
    Name = var.vpc_name
  }

  private_subnet_tags = {
    Type = "Private-Subnet"
  }

  public_subnet_tags = {
    Type = "Public-Subnet"
  }
}