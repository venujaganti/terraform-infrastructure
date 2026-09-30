locals {
  name_prefix = "${var.project_name}-${var.environment}"

  encryption_requirements = {
    EBS = var.require_ebs_encryption
    RDS = var.require_rds_encryption
    S3  = var.require_s3_encryption
  }
}