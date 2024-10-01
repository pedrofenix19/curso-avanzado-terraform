variable "public_key" {
  description = "The public SSH key to be used for the instance."
  type        = string
}

variable "private_key" {
  description = "The private SSH key to connect to the instance."
  type        = string
}

variable "key_pair_name" {
  description = "Name of the Key pair to deploy"
  type        = string
}

variable "number_of_instances" {
  type = number
  default = 3
}

variable "instance_name_prefix" {
  type = string
  description = "Prefix of the instance name"
}

variable "ami_id" {
  description = "AMI ID to use for EC2 instances"
  type        = string
}