# Production Environment

## 1. Purpose

The production environment contains infrastructure used for live workloads.

Environment:

```text
production
```

AWS region:

```text
ap-south-1
```

## 2. Terraform Directory

```text
environments/production/
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
environment  = "production"
project_name = "terraform-infrastructure"
```

## 4. Production Deployment Flow

```text
Feature Branch
      |
      v
Pull Request
      |
      v
Format
      |
      v
Validate
      |
      v
Security Scan
      |
      v
Terraform Plan
      |
      v
Review
      |
      v
Production Apply
```

## 5. Production Validation

Run:

```bash
./scripts/format.sh
```

```bash
./scripts/validate.sh
```

```bash
./scripts/security-scan.sh
```

Generate the production plan:

```bash
./scripts/plan.sh production
```

## 6. Production Apply

After the required review:

```bash
./scripts/apply.sh production
```

## 7. Production Security

Production should use:

* Least-privilege IAM.
* Restricted security groups.
* Encryption.
* Secrets Manager.
* CloudTrail.
* CloudWatch.
* Backup.
* Security scanning.
* Protected CI/CD deployment.
* Controlled changes.

## 8. Production Destruction

Production infrastructure must not be destroyed as part of normal CI/CD operation.

Any destructive operation requires an explicit operational procedure and appropriate authorization.

## 9. Post-Deployment Verification

Verify:

* Application availability.
* Load balancer health.
* EC2 health.
* EKS health.
* Database connectivity.
* DNS.
* CloudFront.
* CloudWatch.
* CloudTrail.
* Logs.
* Backup.
