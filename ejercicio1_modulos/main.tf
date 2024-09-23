provider "aws" {
  region = "us-west-1"
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = var.bucket_name
  force_destroy = true
}

module "ec2_instances" {
  source         = "./modules/ec2-instances"
  instances_name = var.instances_name
  num_instances  = var.num_instances
  tags           = var.tags
}

output "instance_ids" {
  value = module.ec2_instances.instance_ids
}

resource "aws_s3_object" "upload_instance_ids" {
  bucket = aws_s3_bucket.example_bucket.bucket
  key    = "instances-${formatdate("YYYY-MM-DD", timestamp())}.txt"

  content = join("\n", module.ec2_instances.instance_ids)

  acl    = "private"
}
