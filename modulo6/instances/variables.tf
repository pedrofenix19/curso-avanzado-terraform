variable "number_of_instances" {
  type        = number
  description = "Number of EC2 instances to launch"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 instances"
}

variable "instance_name_prefix" {
  type = string
  description = "Prefix of the instance name"
}