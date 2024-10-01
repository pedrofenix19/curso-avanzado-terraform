resource "aws_key_pair" "instance_key_pair" {
  key_name   = var.key_pair_name
  public_key = var.public_key
}

resource "aws_instance" "ec2_instances" {
  count = var.number_of_instances
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.instance_key_pair.key_name

  tags = {
    Name = "${var.instance_name_prefix}-${count.index}"
  }
}
 
resource "null_resource" "ansible" { 
  count = var.number_of_instances
  depends_on = [aws_instance.ec2_instances]

  provisioner "local-exec" {
    command = <<EOT
      ansible-playbook -i ${aws_instance.ec2_instances[count.index].public_ip}, ansible/playbook.yml --private-key ${var.private_key_file_path} -u ubuntu
    EOT
  }

  triggers = {
    instance_ip = aws_instance.ec2_instances[count.index].public_ip
  }
}

