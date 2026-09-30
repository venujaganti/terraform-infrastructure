# Monitoring Module

This module configures Amazon CloudWatch monitoring and metric alarms.

## Features

* CloudWatch EC2 CPU utilization alarm.
* Configurable CPU threshold.
* Configurable evaluation periods.
* Configurable metric period.
* Optional SNS notification topic.
* Configurable missing-data behavior.
* Standard Terraform tags.

## Usage

```hcl
module "monitoring" {
  source = "../../modules/monitoring"

  project_name = "terraform-infrastructure"
  environment  = "dev"

  alarm_instance_id = module.compute.instance_id

  cpu_threshold = 80

  evaluation_periods = 2

  period = 300
}
```

## SNS Notifications

An existing SNS topic can be supplied:

```hcl
module "monitoring" {
  source = "../../modules/monitoring"

  project_name = "terraform-infrastructure"
  environment  = "dev"

  alarm_instance_id = module.compute.instance_id

  sns_topic_arn = "arn:aws:sns:ap-south-1:123456789012:monitoring-alerts"
}
```

When an SNS topic ARN is supplied, CloudWatch sends notifications when the alarm changes state and when it returns to OK.

## Without an EC2 Instance

The alarm is automatically skipped when:

```hcl
alarm_instance_id = null
```

This makes the module safe to use before the compute infrastructure has been connected.

## Outputs

* `aws_region`
* `aws_account_id`
* `cpu_alarm_id`
* `cpu_alarm_arn`
* `cpu_alarm_name`
* `cpu_alarm_enabled`
