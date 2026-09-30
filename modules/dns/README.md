# DNS Module

This module manages Amazon Route 53 public DNS resources.

## Features

* Creates a public Route 53 hosted zone.
* Supports an existing hosted zone.
* Creates optional A alias records.
* Creates optional AAAA alias records.
* Supports CloudFront alias targets.
* Applies standard project and environment tags.

## Usage

```hcl
module "dns" {
  source = "../../modules/dns"

  project_name = "terraform-infrastructure"
  environment  = "dev"

  domain_name = "example.com"

  create_hosted_zone = true

  create_alias_record = true

  record_name = "www.example.com"

  alias_target_dns_name = module.cdn.distribution_domain_name
  alias_target_zone_id  = module.cdn.hosted_zone_id

  enable_ipv6_record = true
}
```

## Existing Hosted Zone

If the hosted zone already exists:

```hcl
module "dns" {
  source = "../../modules/dns"

  project_name = "terraform-infrastructure"
  environment  = "dev"

  domain_name = "example.com"

  create_hosted_zone = false
  hosted_zone_id     = "Z123456789EXAMPLE"
}
```

## Important

For a newly created public hosted zone, the Route 53 name servers must be configured at the domain registrar.

The module does not manage registrar configuration.

## Outputs

* `hosted_zone_id`
* `hosted_zone_name`
* `name_servers`
* `record_name`
* `alias_a_record_fqdn`
* `alias_aaaa_record_fqdn`
