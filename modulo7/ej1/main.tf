resource "aws_key_pair" "instance_key_pair" {
  key_name   = var.key_pair_name
  public_key = var.public_key
}

resource "aws_instance" "ec2_instances" {
  count = var.number_of_instances
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.instance_key_pair.key_name
  security_groups = [aws_security_group.my_ec2_sg]

  tags = {
    Name = "${var.instance_name_prefix}-${count.index}"
  }
}

resource "aws_security_group" "my_ec2_sg" {
  name        = "${var.instance_name_prefix}-sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


# Resource to wait until instance status checks are complete and the instance is running
resource "null_resource" "wait_for_instance" {
  count = var.number_of_instances

  provisioner "local-exec" {
    command = <<EOT
      aws ec2 wait instance-status-ok --instance-ids ${aws_instance.ec2_instances[count.index].id}
    EOT
  }

  triggers = {
    instance_id = aws_instance.ec2_instances[count.index].id
  }

  depends_on = [aws_instance.ec2_instances]
}

resource "null_resource" "ansible" {
  count = var.number_of_instances
  depends_on = [null_resource.wait_for_instance]

  provisioner "local-exec" {
    command = <<EOT
      ansible-playbook -i ${aws_instance.ec2_instances[count.index].public_ip}, ansible/playbook.yml --private-key ${var.private_key_file_path} -u ubuntu
    EOT
  }

  triggers = {
    instance_ip = aws_instance.ec2_instances[count.index].public_ip
  }
}
  
# resource "null_resource" "ansible" { 
#   count = var.number_of_instances
#   depends_on = [aws_instance.ec2_instances]

#   provisioner "local-exec" {
#     command = <<EOT
#       ansible-playbook -i ${aws_instance.ec2_instances[count.index].public_ip}, ansible/playbook.yml --private-key ${var.private_key_file_path} -u ec2-user
#     EOT
#   }

#   triggers = {
#     instance_ip = aws_instance.ec2_instances[count.index].public_ip
#   }
# }

