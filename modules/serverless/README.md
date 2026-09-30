# Serverless Module

This module creates an AWS Lambda function and its execution role.

## Resources

The module creates:

- AWS Lambda function
- Lambda IAM execution role
- Lambda basic execution policy attachment
- CloudWatch Logs group

## Security

The module uses:

- IAM execution role
- AWS managed Lambda basic execution policy
- CloudWatch logging
- Configurable reserved concurrency
- No hard-coded AWS credentials

## Default Configuration

| Setting | Default |
|---|---|
| Runtime | `python3.12` |
| Memory | `256 MB` |
| Timeout | `30 seconds` |
| Architecture | `x86_64` |
| Log retention | `30 days` |
| Reserved concurrency | Disabled |

## Lambda Package

The module expects a ZIP deployment package.

Example:

```hcl
lambda_package_path = "${path.root}/lambda/lambda.zip"