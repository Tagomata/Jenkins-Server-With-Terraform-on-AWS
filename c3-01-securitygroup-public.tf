module "public_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name = "${local.name}-public-sg"
  description = "Security group for public access"
  vpc_id = module.vpc.vpc_id

  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["186.154.36.27/32"] # IP address of the laptop

  egress_rules = ["all-all"]
  
  tags = local.common_tags
}