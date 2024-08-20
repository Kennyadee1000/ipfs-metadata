resource "aws_db_instance" "rds_instance" {
  db_name                         = var.db_name
  identifier                      = var.identifier
  engine                          = var.engine
  engine_version                  = var.engine_version
  publicly_accessible             = var.public_accessible
  allow_major_version_upgrade     = var.allow_version_upgrade
  auto_minor_version_upgrade      = true
  backup_window                   = var.back_up_window
  backup_retention_period         = var.retention_period
  skip_final_snapshot             = true
  final_snapshot_identifier       = "finalsnapshot"
  copy_tags_to_snapshot           = true
  maintenance_window              = var.maintenance_window
  instance_class                  = var.instance_class
  vpc_security_group_ids          = var.vpc_security_group_ids
  allocated_storage               = var.allocated_storage
  storage_type                    = var.storage_type
  apply_immediately               = true
  enabled_cloudwatch_logs_exports = var.cloudwatch_log_report
  username                        = var.username
  password                        = random_password.db_password.result
  multi_az                        = var.enable_multi_az
  deletion_protection             = var.enable_delete_protection
  db_subnet_group_name            = aws_db_subnet_group.db_subnet_group.name
  performance_insights_enabled          = var.performance_insight
  performance_insights_kms_key_id       = aws_kms_key.kms.arn
  performance_insights_retention_period = var.retention_period

}


resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "#&-={}<>:"
}

resource "aws_kms_key" "kms" {
  tags = {
    Name = "rds-performance"
  }
  enable_key_rotation = true
}

resource "aws_kms_alias" "kms_alias" {
  name          = "alias/${var.identifier}"
  target_key_id = aws_kms_key.kms.key_id
}

resource "aws_db_subnet_group" "db_subnet_group" {

  name       = "${lower(var.environment)}-rds"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${lower(var.environment)} subnet grp"
  }
}
