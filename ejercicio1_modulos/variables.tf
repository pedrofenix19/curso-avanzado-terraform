variable "bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
}

variable "instances_name" {
  description = "Nombre base para las instancias EC2"
  type        = string
}

variable "num_instances" {
  description = "Número de instancias EC2 a crear"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Mapa de etiquetas para las instancias EC2"
  type        = map(string)
  default     = {
    Environment = "Dev"
    Project     = "TerraformExample"
  }
}
