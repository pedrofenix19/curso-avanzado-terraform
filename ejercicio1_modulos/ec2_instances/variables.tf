variable "instances_name" {
  description = "Nombre base para las instancias EC2"
  type        = string
}

variable "num_instances" {
  description = "Número de instancias EC2 a crear"
  type        = number
}

variable "tags" {
  description = "Mapa de etiquetas a aplicar a las instancias"
  type        = map(string)
  default     = {}
}
