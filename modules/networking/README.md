# Networking Module

Reusable Terraform module for creating the base AWS networking infrastructure.

## Resources

The module creates:

* VPC
* Internet Gateway
* Public subnets
* Private subnets
* Public route table
* Private route tables
* Route table associations

## Architecture

```text
                         Internet
                            |
                     Internet Gateway
                            |
                         VPC
                     10.0.0.0/16
                            |
             +--------------+--------------+
             |                             |
       Public Subnets                Private Subnets
             |                             |
       Public Route Table           Private Route Tables
             |
        Internet Access
```

## Inputs

| Name                 | Type         | Required | Default       |
| -------------------- | ------------ | -------: | ------------- |
| project_name         | string       |      yes | -             |
| environment          | string       |      yes | -             |
| vpc_cidr             | string       |       no | `10.0.0.0/16` |
| availability_zones   | list(string) |      yes | -             |
| public_subnet_cidrs  | list(string) |      yes | -             |
| private_subnet_cidrs | list(string) |      yes | -             |
| enable_dns_support   | bool         |       no | `true`        |
| enable_dns_hostnames | bool         |       no | `true`        |

## Outputs

* `vpc_id`
* `vpc_cidr`
* `internet_gateway_id`
* `public_subnet_ids`
* `private_subnet_ids`
* `public_route_table_id`
* `private_route_table_ids`
* `availability_zones`

## Example

```hcl
module "networking" {
  source = "../../modules/networking"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr = "10.0.0.0/16"

  availability_zones = [
    "ap-south-1a",
    "ap-south-1b"
  ]

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}
```

## Notes

This module does not create NAT Gateways. NAT Gateway support can be added when private subnet outbound Internet access is required.
