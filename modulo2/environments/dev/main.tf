module "vpc" {
  source = "../../modules/vpc"

  environment = "dev"
  cidr = "10.1.0.0/16"
  name = "pedro-dev-vpc"
  private_subnet = "10.1.1.0/24"
  public_subnets = ["10.1.2.0/24"]
}

module "database" {
  source = "../../modules/rds"

  environment = "dev"

  depends_on = [ module.vpc ]
}

module "servers" {
  source = "../../modules/ec2"
  environment = "dev"
  subnet_ids = module.vpc.public_subnets_ids
  }