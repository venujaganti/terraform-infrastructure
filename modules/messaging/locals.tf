locals {
  name_prefix = "${var.project_name}-${var.environment}"

  queue_name = coalesce(
    var.queue_name,
    "${local.name_prefix}-queue"
  )

  dlq_name = var.fifo_queue ? "${local.name_prefix}-dlq.fifo" : "${local.name_prefix}-dlq"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "messaging"
  }
}