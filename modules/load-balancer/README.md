# Load Balancer Module

This module creates an AWS Application Load Balancer.

## Features

- Application Load Balancer
- Public or internal deployment
- Target group
- HTTP listener
- Health checks
- Multi-AZ subnet support
- Security group support
- Configurable application target port
- Configurable health check path
- Resource tagging

## Default Configuration

| Setting | Default |
|---|---|
| Load balancer type | Application |
| Internal | `false` |
| Listener | HTTP |
| Listener port | `80` |
| Target protocol | HTTP |
| Target port | `80` |
| Health check path | `/` |
| Health check interval | `30 seconds` |
| Deletion protection | `false` |

## Dependencies

This module expects:

- Networking module
- Security module
- VPC
- At least two subnets
- Security group

## Example

```hcl
module "load_balancer" {
  source = "../../modules/load-balancer"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.networking.vpc_id

  subnet_ids = module.networking.public_subnet_ids

  security_group_ids = [
    module.security.security_group_id
  ]

  listener_port = 80
  target_port   = 80

  health_check_path = "/"
}