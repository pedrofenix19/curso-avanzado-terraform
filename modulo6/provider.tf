terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.68.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "curso-iac-avanzado-states"
    key            = "pedro/modulo6-ej2/terraform.tfstate"
    region         = "us-east-1"
  }
}