output "instance_ips" {
  description = "Map of instance ID to its public IP"
  value = { 
    for instance in aws_instance.ec2_instances : instance.id => instance.public_ip 
  }
}