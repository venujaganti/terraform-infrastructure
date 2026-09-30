resource "aws_cloudwatch_metric_alarm" "ec2_cpu_high" {
  count = (
    var.create_cpu_alarm &&
    var.alarm_instance_id != null
  ) ? 1 : 0

  alarm_name = local.cpu_alarm_name

  alarm_description = var.alarm_description

  comparison_operator = var.comparison_operator

  evaluation_periods = var.evaluation_periods

  metric_name = "CPUUtilization"

  namespace = "AWS/EC2"

  period = var.period

  statistic = var.statistic

  threshold = var.cpu_threshold

  treat_missing_data = var.treat_missing_data

  dimensions = {
    InstanceId = var.alarm_instance_id
  }

  alarm_actions = (
    var.sns_topic_arn != null
    ? [var.sns_topic_arn]
    : []
  )

  ok_actions = (
    var.sns_topic_arn != null
    ? [var.sns_topic_arn]
    : []
  )

  insufficient_data_actions = []

  tags = merge(
    local.common_tags,
    {
      Name = local.cpu_alarm_name
      Type = "EC2-CPU"
    }
  )
}