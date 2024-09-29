resource "aws_instance" "instances" {
  for_each = { for index, name in var.instance_names: index => name}

  ami           = "ami-0ebfd941bbafe70c6"
  instance_type = "t2.micro"

  tags = {
    Name = "pedro-${each.value}"
  }
}