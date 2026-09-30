# Identity Module

Reusable Terraform module for AWS IAM resources required by EC2.

## Resources

The module creates:

* EC2 IAM role
* EC2 IAM instance profile
* Optional AWS Systems Manager policy attachment

## IAM Flow

```text
EC2 Instance
     |
     v
Instance Profile
     |
     v
EC2 IAM Role
     |
     v
AmazonSSMManagedInstanceCore
```

## Security

The module does not create IAM users or access keys.

EC2 receives permissions through an IAM instance profile.

## Example

```hcl
module "identity" {
  source = "../../modules/identity"

  project_name = var.project_name
  environment  = var.environment

  create_ssm_access = true
}
```

## Outputs

* `ec2_role_name`
* `ec2_role_arn`
* `instance_profile_name`
* `instance_profile_arn`
