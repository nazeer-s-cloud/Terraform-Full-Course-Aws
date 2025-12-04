output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.day05.public_ip
}

output "ssh_command" {
  description = "SSH command to connect"
  value       = "ssh -i ~/.ssh/${var.ssh_key_name}.pem ec2-user@${aws_instance.day05.public_ip}"
}
