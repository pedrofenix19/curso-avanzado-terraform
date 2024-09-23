provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  count         = var.num_instances
  ami           = "ami-0ebfd941bbafe70c6"  # AMI de ejemplo
  instance_type = "t2.micro"

  tags = merge(
    var.tags,
    {
      Name = "${var.instances_name}-${count.index}"
    }
  )
}