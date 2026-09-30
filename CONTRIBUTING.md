# Contributing Guide

## Development Workflow

1. Create a feature branch.
2. Make the required changes.
3. Format Terraform code.
4. Validate Terraform configuration.
5. Run TFLint.
6. Review the changes.
7. Commit the changes.
8. Create a pull request.

## Terraform Checks

Run:

```bash
terraform fmt -recursive
make validate
tflint --recursive
```

## Commit Messages

Use clear and descriptive commit messages.

Example:

```text
feat: add VPC module
fix: correct security group rule
docs: update infrastructure documentation
```

## Security

Do not commit:

* AWS access keys
* Private keys
* `.pem` files
* Terraform state files
* Passwords
* Secrets
* Sensitive `.tfvars` files
