#=========================== vpn/data.tf ========================

data "aws_ami" "vpn_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-*"]
  }

  owners = ["099720109477"]
}

data "aws_kms_alias" "kms-ebs" {
  name = "alias/aws/ebs"
}

data "aws_instance" "vpn" {
  filter {
    name   = "tag:Name"
    values = ["${var.env}-vpn"]
  }

  depends_on = [
    aws_autoscaling_group.vpn_auto_scaling_group
  ]
}