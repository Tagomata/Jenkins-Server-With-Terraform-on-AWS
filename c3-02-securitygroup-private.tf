module "private_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name        = "${local.name}-private-sg"
  description = "Security group for private access"
  vpc_id      = module.vpc.vpc_id

  ingress_rules       = ["ssh-tcp", "http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = [module.vpc.public_subnets_cidr_blocks[0]]

  egress_rules = ["all-all"]

  tags = local.common_tags
}