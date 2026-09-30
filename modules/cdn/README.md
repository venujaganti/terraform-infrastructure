# CDN Module

This module creates an Amazon CloudFront distribution for an application origin.

## Features

* CloudFront distribution.
* Custom origin support.
* HTTPS viewer redirection.
* IPv6 support.
* Compression.
* Configurable cache methods.
* Configurable price class.
* Optional custom domain names.
* Optional ACM certificate.
* TLS 1.2 support.
* Optional custom error responses.
* Standard project and environment tags.

## Basic Usage

```hcl
module "cdn" {
  source = "../../modules/cdn"

  project_name = "terraform-infrastructure"
  environment  = "dev"

  origin_domain_name = "my-application.example.com"
}
```

## Custom Domain

For a custom CloudFront domain:

```hcl
module "cdn" {
  source = "../../modules/cdn"

  project_name = "terraform-infrastructure"
  environment  = "dev"

  origin_domain_name = "my-application.example.com"

  aliases = [
    "www.example.com"
  ]

  acm_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/example"
}
```

## Important ACM Requirement

For CloudFront, the ACM certificate must be issued in the `us-east-1` AWS region.

The certificate must cover every domain configured in `aliases`.

## Origin

The origin hostname must not include:

```text
http://
```

or:

```text
https://
```

Correct:

```text
my-application.example.com
```

Incorrect:

```text
https://my-application.example.com
```

## Outputs

* `distribution_id`
* `distribution_arn`
* `distribution_domain_name`
* `hosted_zone_id`
* `status`
* `enabled`

The `distribution_domain_name` and `hosted_zone_id` can be passed to the DNS module to create Route 53 CloudFront alias records.
