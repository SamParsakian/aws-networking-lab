output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_instance_public_ip" {
  description = "Address used to SSH into the public instance"
  value       = aws_instance.public.public_ip
}

output "public_instance_private_ip" {
  value = aws_instance.public.private_ip
}

output "private_instance_private_ip" {
  description = "Address of the private instance, reachable only from inside the VPC"
  value       = aws_instance.private.private_ip
}

output "nat_gateway_public_ip" {
  description = "Public address that all outbound traffic of the private subnet appears from"
  value       = aws_eip.nat.public_ip
}
