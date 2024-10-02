terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.5.2"
    }
  }
}

provider "local" {
  # Configuration options
}

variable "nombre_archivo_1" {
  type = string
  default = "archivo_1.txt"
}

variable "nombre_archivo_2" {
  type = string
  default = "archivo_2.txt"
}

resource "local_file" "archivo_1" {
  filename = var.nombre_archivo_1
  content = var.nombre_archivo_2
}

resource "local_file" "archivo_2" {
  filename = var.nombre_archivo_2
  content = var.nombre_archivo_1
}