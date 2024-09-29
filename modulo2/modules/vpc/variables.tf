variable "environment" {
  type = string
  description = "Environment"
}

variable "cidr" {
  type = string
  description = "VPC CIDR"
}

variable "name" {
  type = string
  description = "VPC Name"
}

variable "private_subnets" {
  type = list(string)
  description = "Subnet to deploy database"
}

variable "public_subnets" {
  type = list(string)
  description = "Subnets to deploy EC2 instances"
}