resource "aws_db_instance" "postgres_database" {
  count                        = length(var.db_identifier)
  identifier                   = "${var.env}-${var.db_identifier}"
  allocated_storage            = var.allocated_storage
  max_allocated_storage        = var.max_allocated_storage
  storage_type                 = var.storage_type
  engine                       = "postgres"
  engine_version               = var.database_version
  instance_class               = var.database_instance_class
  name                         = var.database_name
  username                     = var.database_master_user
  password                     = var.database_master_user_password
  snapshot_identifier          = var.snapshot_identifier
  publicly_accessible          = false
  multi_az                     = var.use_multiple_availability_zones
  storage_encrypted            = var.use_encrypted_storage
  skip_final_snapshot          = true
  db_subnet_group_name         = aws_db_subnet_group.postgres_database_subnet_group.name
  allow_major_version_upgrade  = var.allow_major_version_upgrade
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  performance_insights_enabled = var.performance_insights_enabled

  vpc_security_group_ids = [
    aws_security_group.postgres_database_security_group.id, var.additional_sg
  ]

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  tags = {
    Name                 = "${var.env}-${var.db_identifier}"
    DeploymentIdentifier = var.db_identifier
  }
}



#============================ DB Security Group ============================
resource "aws_security_group" "postgres_database_security_group" {
  name        = "sg-${var.env}-${var.db_identifier}"
  description = "Allow access to PostgreSQL database from private network."
  vpc_id      = var.vpc_id

  tags = {
    Name                 = "sg-${var.env}-${var.db_identifier}"
    DeploymentIdentifier = var.db_identifier
  }

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    cidr_blocks = [
      var.private_network_cidr
    ]
  }

  dynamic "ingress" {
    for_each = var.include_self_ingress_rule == true ? [1] : []
    content {
      self      = true
      from_port = 0
      to_port   = 65535
      protocol  = "tcp"
    }
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}
