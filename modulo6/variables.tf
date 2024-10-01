variable "ami_id" {
  description = "AMI ID to use for EC2 instances"
  type        = string
}

variable "number_of_instances" {
  type        = number
  description = "Number of EC2 instances to launch"
}

variable "instance_name_prefix" {
  type = string
  description = "Prefix of the instance name"
}