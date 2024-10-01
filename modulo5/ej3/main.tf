resource "aws_security_group" "server_sg" {
  name        = "Server SG"
  description = "Server SG"
}

resource "aws_vpc_security_group_ingress_rule" "http_access" {
  security_group_id = aws_security_group.server_sg.id

  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
}