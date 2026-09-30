variable "terraform_minimum_version" {
  description = "Minimum Terraform version."
  type        = string
  default     = "1.9.0"
}

variable "terraform_maximum_version" {
  description = "Exclusive maximum Terraform major version."
  type        = string
  default     = "2.0.0"
}

variable "aws_provider_constraint" {
  description = "AWS provider version constraint."
  type        = string
  default     = "~> 6.0"
}