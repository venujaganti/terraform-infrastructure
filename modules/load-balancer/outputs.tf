output "load_balancer_id" {
  description = "ID of the Application Load Balancer."
  value       = aws_lb.this.id
}

output "load_balancer_arn" {
  description = "ARN of the Application Load Balancer."
  value       = aws_lb.this.arn
}

output "load_balancer_name" {
  description = "Name of the Application Load Balancer."
  value       = aws_lb.this.name
}

output "load_balancer_dns_name" {
  description = "DNS name of the Application Load Balancer."
  value       = aws_lb.this.dns_name
}

output "target_group_id" {
  description = "ID of the Application Load Balancer target group."
  value       = aws_lb_target_group.this.id
}

output "target_group_arn" {
  description = "ARN of the Application Load Balancer target group."
  value       = aws_lb_target_group.this.arn
}

output "target_group_name" {
  description = "Name of the Application Load Balancer target group."
  value       = aws_lb_target_group.this.name
}

output "listener_arn" {
  description = "ARN of the HTTP listener."
  value       = aws_lb_listener.http.arn
}