#======================= VPN Launch Template =========================

resource "aws_launch_template" "vpn_launch_template" {
  name_prefix            = "${var.env}-vpn-launch-template"
  image_id               = data.aws_ami.vpn_ami.id
  instance_type          = var.instance_type
  update_default_version = true

  monitoring {
    enabled = true
  }

  vpc_security_group_ids = concat([aws_security_group.vpn_sg.id], var.vpn_additional_security_groups)



  key_name = var.vpn_key_pair == "" ? null : var.vpn_key_pair

  user_data = base64encode(file("${path.module}/user_data.sh"))

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = var.disk_size
      volume_type           = "gp2"
      delete_on_termination = true
      encrypted             = var.disk_encrypt
      kms_key_id            = var.disk_encrypt ? data.aws_kms_alias.kms-ebs.target_key_arn : ""
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.env}-vpn"
    }
  }

  tag_specifications {
    resource_type = "volume"
    tags = {
      Name = "${var.env}-vpn"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

#======================= VPN Autoscaling Group =========================

resource "aws_autoscaling_group" "vpn_auto_scaling_group" {
  name_prefix = "${var.env}-vpn-autoscaling"
  launch_template {
    id      = aws_launch_template.vpn_launch_template.id
    version = aws_launch_template.vpn_launch_template.latest_version
  }
  max_size         = 1
  min_size         = 1
  desired_capacity = 1

  vpc_zone_identifier = var.vpn_subnets

  default_cooldown          = 180
  health_check_grace_period = 180
  health_check_type         = "EC2"
  target_group_arns         = aws_lb_target_group.vpn_target_group[*].arn




  termination_policies = [
    "OldestLaunchTemplate",
  ]

  dynamic "tag" {
    for_each = var.tags

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  tag {
    key                 = "Name"
    value               = "${var.env}-vpn"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}


#======================= VPN Security Group =========================

resource "aws_security_group" "vpn_sg" {
  name        = "${upper(var.env)}-VPN-SG"
  description = "Security group for VPN instance."
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags)
}

resource "aws_security_group_rule" "openvpn_rule" {
  description = "VPN Tunnel."
  type        = "ingress"
  from_port   = "1194"
  to_port     = "1194"
  protocol    = "UDP"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.vpn_sg.id
}

resource "aws_security_group_rule" "openvpn_admin_rule" {
  description = "Port for VPN Admin."
  type        = "ingress"
  from_port   = "943"
  to_port     = "943"
  protocol    = "TCP"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.vpn_sg.id
}

resource "aws_security_group_rule" "openvpn_client_rule" {
  description = "Port for VPN Client."
  type        = "ingress"
  from_port   = "443"
  to_port     = "443"
  protocol    = "TCP"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.vpn_sg.id
}

resource "aws_security_group_rule" "openvpn_http_rule" {
  description = "Port for VPN Client."
  type        = "ingress"
  from_port   = "80"
  to_port     = "80"
  protocol    = "TCP"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.vpn_sg.id
}

resource "aws_security_group_rule" "openvpn_ssh_rule" {
  description = "SSH port for VPN instance."
  type        = "ingress"
  from_port   = "22"
  to_port     = "22"
  protocol    = "TCP"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.vpn_sg.id
}


#======================= VPN Load Balancer =========================

resource "aws_lb" "vpn_lb" {
  internal = false
  name     = "${var.env}-vpn-lb"

  subnets            = var.vpn_subnets
  load_balancer_type = "network"
}

resource "aws_lb_target_group" "vpn_target_group" {
  count       = length(var.vpn_ports)
  name        = "${var.env}-lb-target-port-${var.vpn_ports[count.index]}"
  port        = var.vpn_ports[count.index]
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    port     = "traffic-port"
    protocol = "TCP"
  }
}

resource "aws_lb_listener" "vpn_lb_listener" {
  count = length(var.vpn_ports)
  default_action {
    target_group_arn = aws_lb_target_group.vpn_target_group[count.index].arn
    type             = "forward"
  }

  load_balancer_arn = aws_lb.vpn_lb.arn
  port              = var.vpn_ports[count.index]
  protocol          = "TCP"
}