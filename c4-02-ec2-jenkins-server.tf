module "ec2_jenkins_server" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.0"

  name = "${var.stack}-jenkins-${var.environment}"
  ami = data.aws_ami.ubuntu_24.id
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = module.private_subnets.private_subnets_ids[0]
  vpc_security_group_ids = [module.private_security_group.security_group_id]

  user_data = file("./jenkins-server-install.sh")

  tags = local.common_tags
}