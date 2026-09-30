output "instance_id" {
  description = "ID of the EC2 instance."
  value       = aws_instance.this.id
}

output "instance_arn" {
  description = "ARN of the EC2 instance."
  value       = aws_instance.this.arn
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance."
  value       = aws_instance.this.private_ip
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance."
  value       = aws_instance.this.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance."
  value       = aws_instance.this.public_dns
}

output "instance_type" {
  description = "EC2 instance type."
  value       = aws_instance.this.instance_type
}

output "availability_zone" {
  description = "Availability zone of the EC2 instance."
  value       = aws_instance.this.availability_zone
}

output "root_volume_id" {
  description = "ID of the root EBS volume."
  value       = aws_instance.this.root_block_device[0].volume_id
}