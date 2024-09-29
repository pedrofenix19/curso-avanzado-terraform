resource "aws_s3_bucket" "ips_bucket" {
  bucket_prefix = "${var.instance_name_prefix}-ips-bucket-"
}

module "ec2_instances" {
  source             = "./instances"
  ami_id             = var.ami_id
  number_of_instances = var.number_of_instances
  instance_name_prefix = var.instance_name_prefix
}

resource "aws_s3_object" "public_ip_files" {
count   = length(module.ec2_instances.instance_ips)

  bucket  = aws_s3_bucket.ips_bucket.bucket
  key     = "${var.instance_name_prefix}-ip-${count.index}.txt"
  content = module.ec2_instances.instance_ips[count.index]

  depends_on = [module.ec2_instances]
}
