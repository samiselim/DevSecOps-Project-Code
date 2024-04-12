output "ip" {
  description = "Ec2 Public IP"
  value       = aws_instance.ubuntu.public_ip
}
