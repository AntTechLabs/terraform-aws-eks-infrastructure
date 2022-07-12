#===================== bastion/data.tf =======================
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  name_regex  = "^amzn2-ami-hvm.*-ebs"

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_subnet" "subnets" {
  count = length(var.elb_subnets)
  id    = var.elb_subnets[count.index]
}

data "aws_kms_alias" "kms-ebs" {
  name = "alias/aws/ebs"
}

data "aws_instance" "bastion" {
  filter {
    name   = "tag:Name"
    values = ["${var.env}-${var.bastion_name}"]
  }

  depends_on = [
    aws_autoscaling_group.bastion_auto_scaling_group
  ]
}

