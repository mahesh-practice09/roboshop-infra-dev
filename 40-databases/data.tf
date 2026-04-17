data "aws_ami" "devopsami" {
  most_recent = true
  owners      = ["973714476881"] # Canonical's AWS Account ID

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.Project}/${var.environment}/vpc"
}

data "aws_ssm_parameter" "db_private_subnet_ids" {
  name  = "/${var.Project}/${var.environment}/db_private_subnet_ids"
}

data "aws_ssm_parameter" "mongodb_sg_id" {
  name  = "/${var.Project}/${var.environment}/mongodb_sg_id"
}

data "aws_ssm_parameter" "redis_sg_id" {
  name  = "/${var.Project}/${var.environment}/redis_sg_id"
}

data "aws_ssm_parameter" "mysql_sg_id" {
  name  = "/${var.Project}/${var.environment}/mysql_sg_id"
}

data "aws_ssm_parameter" "rabbitmq_sg_id" {
  name  = "/${var.Project}/${var.environment}/rabbitmq_sg_id"
}


