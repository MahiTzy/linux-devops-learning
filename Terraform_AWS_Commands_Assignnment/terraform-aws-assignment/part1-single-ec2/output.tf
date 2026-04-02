output "ec2_public_ip" {
  value = try(aws_instance.app.public_ip, null)
}