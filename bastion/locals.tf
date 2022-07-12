#======================= bastion/locals.tf ==========================
locals {
  name_prefix    = "${var.env}-${var.bastion_name}"
  security_group = join("", flatten([aws_security_group.bastion_host_security_group[*].id, var.bastion_security_group_id]))
}

