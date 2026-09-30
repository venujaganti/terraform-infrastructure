locals {
  normalized_tags = {
    for key, value in var.required_tags :
    trimspace(key) => trimspace(value)
  }
}