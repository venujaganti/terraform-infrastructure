resource "aws_cloudwatch_log_group" "application" {
  count = var.create_application_log_group ? 1 : 0

  name = local.application_log_group_name

  retention_in_days = var.application_log_retention_days

  kms_key_id = var.kms_key_id

  skip_destroy = var.skip_destroy

  tags = merge(
    local.common_tags,
    {
      Name = local.application_log_group_name
      Type = "application"
    }
  )
}

resource "aws_cloudwatch_log_group" "system" {
  count = var.create_system_log_group ? 1 : 0

  name = local.system_log_group_name

  retention_in_days = var.system_log_retention_days

  kms_key_id = var.kms_key_id

  skip_destroy = var.skip_destroy

  tags = merge(
    local.common_tags,
    {
      Name = local.system_log_group_name
      Type = "system"
    }
  )
}

resource "aws_cloudwatch_log_group" "audit" {
  count = var.create_audit_log_group ? 1 : 0

  name = local.audit_log_group_name

  retention_in_days = var.audit_log_retention_days

  kms_key_id = var.kms_key_id

  skip_destroy = var.skip_destroy

  tags = merge(
    local.common_tags,
    {
      Name = local.audit_log_group_name
      Type = "audit"
    }
  )
}