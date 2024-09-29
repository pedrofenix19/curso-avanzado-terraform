

module "instances" {
  source = "./instances"

  instance_names = var.instance_names
}