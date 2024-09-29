resource "local_file" "dev_database" {
  count    = var.environment == "dev" ? 1 : 0
  filename = "dev_database.sqlite"
  content = "hola"
}


module "prod_database" {
  source = "terraform-aws-modules/rds/aws"

  count = var.environment == "prod" ? 1 : 0

  identifier = var.rds_instance_name

  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "demodb"
  username = "user"
  port     = "3306"

#   iam_database_authentication_enabled = true

#   vpc_security_group_ids = ["sg-12345678"]

#   maintenance_window = "Mon:00:00-Mon:03:00"
#   backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
#   monitoring_interval    = "30"
#   monitoring_role_name   = "MyRDSMonitoringRole"
#   create_monitoring_role = true

  tags = {
    Environment = var.environment
  }

#   # DB subnet group
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

#   # DB parameter group
  family = "mysql5.7"

#   # DB option group
  major_engine_version = "5.7"

}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "pedro-subnet-group"
  subnet_ids = var.rds_subnets

  tags = {
    Name = "RDS subnet group"
  }
}