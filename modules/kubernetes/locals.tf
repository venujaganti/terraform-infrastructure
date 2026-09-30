locals {
  name_prefix = "${var.project_name}-${var.environment}"

  eks_node_subnet_ids = coalesce(
    var.node_subnet_ids,
    var.subnet_ids
  )

  first_subnet_id = var.subnet_ids[0]

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "kubernetes"
  }
}