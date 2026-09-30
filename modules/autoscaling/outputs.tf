output "autoscaling_group_id" {
  description = "ID of the Auto Scaling Group."
  value       = aws_autoscaling_group.this.id
}

output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group."
  value       = aws_autoscaling_group.this.name
}

output "launch_template_id" {
  description = "ID of the EC2 Launch Template."
  value       = aws_launch_template.this.id
}

output "launch_template_name" {
  description = "Name of the EC2 Launch Template."
  value       = aws_launch_template.this.name
}

output "launch_template_latest_version" {
  description = "Latest version of the EC2 Launch Template."
  value       = aws_launch_template.this.latest_version
}

output "min_size" {
  description = "Minimum Auto Scaling capacity."
  value       = aws_autoscaling_group.this.min_size
}

output "desired_capacity" {
  description = "Desired Auto Scaling capacity."
  value       = aws_autoscaling_group.this.desired_capacity
}

output "max_size" {
  description = "Maximum Auto Scaling capacity."
  value       = aws_autoscaling_group.this.max_size
}