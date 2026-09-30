# Rollback Operations

## 1. Overview

Terraform does not provide a traditional application rollback command.

Infrastructure rollback is performed by restoring a known-good Terraform configuration and applying the resulting plan.

```text
Problem
   |
   v
Identify Change
   |
   v
Restore Known-Good Configuration
   |
   v
Validate
   |
   v
Plan
   |
   v
Review
   |
   v
Apply
   |
   v
Verify
```

## 2. Identify the Change

Determine:

* Affected environment.
* Affected resource.
* Recent Terraform change.
* Git commit.
* Application impact.
* Infrastructure impact.

View recent commits:

```bash
git log --oneline
```

## 3. Create Rollback Branch

```bash
git checkout -b rollback/infrastructure
```

Restore the approved known-good configuration through the normal Git workflow.

## 4. Validate

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

## 5. Generate Rollback Plan

Development:

```bash
./scripts/plan.sh dev
```

Staging:

```bash
./scripts/plan.sh staging
```

Production:

```bash
./scripts/plan.sh production
```

## 6. Review Destructive Changes

Pay special attention to:

```text
destroy
```

and:

```text
-/+
```

A `-/+` change means Terraform may replace a resource.

Unexpected production resource destruction must be investigated before applying.

## 7. Application Rollback

### EC2

Restore the previously approved application version.

### EKS

Deploy the previously approved ECR image.

### Lambda

Deploy the previously approved Lambda version or package.

### Database

Database schema rollback must be handled separately from Terraform infrastructure rollback.

## 8. Database Recovery

If a database issue occurs:

1. Restrict application writes if required.
2. Identify the affected database.
3. Identify a valid backup.
4. Determine the recovery point.
5. Restore the database.
6. Validate the data.
7. Restore application connectivity.
8. Monitor the database.

## 9. Verification

After rollback verify:

* [ ] Terraform state is consistent.
* [ ] Application is healthy.
* [ ] EC2 is healthy.
* [ ] EKS workloads are healthy.
* [ ] Load balancer health checks pass.
* [ ] DNS works.
* [ ] CloudFront works.
* [ ] CloudWatch metrics work.
* [ ] Logs are available.
* [ ] No unexpected Terraform changes remain.

## 10. Incident Documentation

Record:

* Incident date and time.
* Environment.
* Affected resources.
* Problem.
* Original Git commit.
* Rollback commit.
* Terraform plan.
* Recovery actions.
* Verification results.
* Follow-up actions.
