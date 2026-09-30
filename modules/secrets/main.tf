resource "aws_secretsmanager_secret" "this" {
  name = local.secret_name

  description = var.description

  kms_key_id = var.kms_key_id

  force_overwrite_replica_secret = var.force_overwrite_replica_secret

  recovery_window_in_days = var.recovery_window_in_days

  tags = merge(
    local.common_tags,
    {
      Name = local.secret_name
    }
  )

  lifecycle {
    precondition {
      condition = !(
        var.secret_value != null &&
        length(var.secret_values) > 0
      )

      error_message = "Use either secret_value or secret_values, not both."
    }
  }
}

resource "aws_secretsmanager_secret_version" "this" {
  count = local.secret_string != null ? 1 : 0

  secret_id = aws_secretsmanager_secret.this.id

  secret_string = local.secret_string
}