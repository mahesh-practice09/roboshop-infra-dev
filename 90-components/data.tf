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

data "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.Project}/${var.environment}/private_subnet_ids"
}

data "aws_ssm_parameter" "backendalb_listener_arn" {
  name  = "/${var.Project}/${var.environment}/backendalb_listener_arn"
}


data "aws_ssm_parameter" "bastion_sg_id" {
  
  name = "/${var.Project}/${var.environment}/bastion_sg_id"
}

data "aws_ssm_parameter" "mongodb_sg_id" {
  
  name = "/${var.Project}/${var.environment}/mongodb_sg_id"
}

data "aws_ssm_parameter" "user_sg_id" {
  
  name = "/${var.Project}/${var.environment}/user_sg_id"
}

data "aws_ssm_parameter" "redis_sg_id" {
  
  name = "/${var.Project}/${var.environment}/redis_sg_id"
}

data "aws_ssm_parameter" "rabbitmq_sg_id" {
  
  name = "/${var.Project}/${var.environment}/rabbitmq_sg_id"
}

data "aws_ssm_parameter" "mysql_sg_id" {
  
  name = "/${var.Project}/${var.environment}/mysql_sg_id"
}

data "aws_ssm_parameter" "cart_sg_id" {
  
  name = "/${var.Project}/${var.environment}/cart_sg_id"
}

data "aws_ssm_parameter" "shipping_sg_id" {
  
  name = "/${var.Project}/${var.environment}/shipping_sg_id"
}

data "aws_ssm_parameter" "payment_sg_id" {
  
  name = "/${var.Project}/${var.environment}/payment_sg_id"
}

data "aws_ssm_parameter" "backend_alb_sg_id" {
  
  name = "/${var.Project}/${var.environment}/backend_alb_sg_id"
}




data "aws_ssm_parameter" "frontend_alb_sg_id" {
  
  name = "/${var.Project}/${var.environment}/frontend_alb_sg_id"
}