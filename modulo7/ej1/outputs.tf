output "instance_ips" {
  value = [for instance in aws_instance.ec2_instances : instance.public_ip]
}