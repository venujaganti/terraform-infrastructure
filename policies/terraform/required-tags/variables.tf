variable "required_tags" {
  description = "Tags that every environment should define."
  type        = map(string)

  default = {
    Project     = "terraform-infrastructure"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }

  validation {
    condition = alltrue([
      for key, value in var.required_tags :
      trimspace(key) != "" && trimspace(value) != ""
    ])

    error_message = "Required tag keys and values must not be empty."
  }
}