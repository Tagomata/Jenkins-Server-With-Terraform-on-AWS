module "ec2_bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.0"

  name = "${var.stack}-bastion-${var.environment}"

  ami = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = module.public_subnets.public_subnets_ids[0]
  vpc_security_group_ids = [module.public_security_group.security_group_id]

  tags = local.common_tags

}