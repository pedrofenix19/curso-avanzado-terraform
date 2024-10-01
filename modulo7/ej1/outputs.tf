output "instance_ips" {
  value = [for instance in aws_instance.example : instance.public_ip]
}