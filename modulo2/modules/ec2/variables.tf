variable "environment" {
  description = "Environment"
  type        = string

  validation {
    condition     = can(regex("(dev|prod)", var.environment))
    error_message = "Environment must be dev or prod."
  }
}

variable "subnet_ids" {
  description = "List of subnet IDs where instances will be deployed"
  type        = list(string)
}

variable "instances_per_subnet" {
  description = "Number of instances to deploy per subnet"
  type        = number
  default     = 1
}
