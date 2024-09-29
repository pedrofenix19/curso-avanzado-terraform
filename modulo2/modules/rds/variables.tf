variable "environment" {
  type        = string
  description = "Environment"

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be either 'dev' or 'prod'."
  }
}

variable "rds_instance_name" {
  type = string
  description = "Name of the RDS instance"
  default = ""
}

variable "rds_subnets" {
  type = list(string)
  description = "Subnets to deploy RDS"
  default = []
}

locals {
  validate_rds_instance = (var.environment == "prod" && var.rds_instance_name == "") ? tobool("Please specify rds instance name"): false
}