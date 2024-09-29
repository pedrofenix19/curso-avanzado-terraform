module "vpc" {
  source = "../../modules/vpc"

  environment = "prod"
  cidr = "10.1.0.0/16"
  name = "pedro-vpc"
  private_subnets = ["10.1.10.0/24", "10.1.11.0/24", "10.1.12.0/24"]
  public_subnets = ["10.1.2.0/24", "10.1.3.0/24", "10.1.4.0/24"]
}

module "database" {
  source = "../../modules/rds"

  environment = "prod"
  rds_instance_name = "pedro-rds"
  rds_subnets = module.vpc.private_subnets
}

module "servers" {
  source = "../../modules/ec2"
  environment = "prod"
  subnet_ids = module.vpc.public_subnets_ids
  instances_per_subnet = 2
  }