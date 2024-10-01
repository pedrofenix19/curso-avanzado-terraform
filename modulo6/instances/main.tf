resource "aws_instance" "ec2_instances" {
  count         = var.number_of_instances
  ami           = var.ami_id
  instance_type = "t2.micro"

  tags = {
    Name = "${var.instance_name_prefix}-${count.index}"
  }
}