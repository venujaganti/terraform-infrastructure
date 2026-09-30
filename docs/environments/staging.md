# Staging Environment

## 1. Purpose

The staging environment is used for pre-production validation, integration testing, deployment testing, and operational testing.

Environment:

```text
staging
```

AWS region:

```text
ap-south-1
```

## 2. Terraform Directory

```text
environments/staging/
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

```hcl
aws_region   = "ap-south-1"
environment  = "staging"
project_name = "terraform-infrastructure"
```

## 4. Validation

Run:

```bash
./scripts/format.sh
./scripts/validate.sh
./scripts/security-scan.sh
```

## 5. Terraform Plan

```bash
./scripts/plan.sh staging
```

Review the complete plan before applying.

## 6. Terraform Apply

```bash
./scripts/apply.sh staging
```

## 7. Staging Verification

Verify:

* Network connectivity.
* Security groups.
* EC2 health.
* Load balancer health.
* Kubernetes workloads.
* Database connectivity.
* DNS resolution.
* CloudFront delivery.
* CloudWatch metrics.
* CloudWatch alarms.
* Logging.
* Backup configuration.

## 8. Promotion

The normal promotion flow is:

```text
Development
     |
     v
Pull Request
     |
     v
Staging
     |
     v
Validation
     |
     v
Production
```
