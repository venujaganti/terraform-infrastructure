resource "aws_db_subnet_group" "this" {
  name       = "${local.name_prefix}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-db-subnet-group"
    }
  )
}

resource "aws_db_instance" "this" {
  identifier = "${local.name_prefix}-postgres"

  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = true

  db_name  = var.database_name
  username = var.master_username

  manage_master_user_password = true

  port = var.port

  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.security_group_ids

  publicly_accessible = false

  multi_az = var.multi_az

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  deletion_protection = var.deletion_protection
  skip_final_snapshot = var.skip_final_snapshot

  apply_immediately = var.apply_immediately

  auto_minor_version_upgrade = true

  copy_tags_to_snapshot = true

  enabled_cloudwatch_logs_exports = [
    "postgresql",
    "upgrade"
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-postgres"
    }
  )
}