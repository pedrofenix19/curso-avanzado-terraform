terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.69.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "curso-iac-avanzado-states"
    key            = "pedro/modulo5-ej3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tabla-bloqueo-terraform2"
  }
}