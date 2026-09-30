# Development Environment

## 1. Purpose

The development environment is used for Terraform development, infrastructure testing, application development, and integration testing.

Environment:

```text
dev
```

AWS region:

```text
ap-south-1
```

## 2. Terraform Directory

```text
environments/dev/
```

Expected files:

```text
backend.tf
providers.tf
versions.tf
main.tf
variables.tf
locals.tf
data.tf
outputs.tf
terraform.tfvars
```

## 3. Environment Variables

The development environment uses:

```hcl
aws_region   = "ap-south-1"
environment  = "dev"
project_name = "terraform-infrastructure"
```

## 4. Validation

From the project root:

```bash
./scripts/format.sh
./scripts/validate.sh
./scripts/security-scan.sh
```

## 5. Terraform Plan

```bash
./scripts/plan.sh dev
```

Review the plan before applying.

## 6. Terraform Apply

```bash
./scripts/apply.sh dev
```

## 7. Development Rules

Development resources should:

* Use standard project tags.
* Use encryption.
* Use restricted security groups.
* Avoid unnecessary public exposure.
* Use test data where appropriate.
* Be validated before promotion to staging.

## 8. Promotion

The development flow is:

```text
Development
     |
     v
Validation
     |
     v
Pull Request
     |
     v
Staging
```
