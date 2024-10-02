variable "instance_names" {
  type        = list(string)
  description = "Nombres de las instancias a crear"
  default = [ "instancia1", "instancia2", "instancia_extra" ]
}