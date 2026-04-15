data "http" "my_public_ip" {
  url = "https://ipv4.icanhazip.com"
}

data "aws_ssm_parameter" "bastion_sg_id" {
  
  name = "/${var.Project}/${var.Env}/bastion_sg_id"
}

data "aws_ssm_parameter" "mongodb_sg_id" {
  
  name = "/${var.Project}/${var.Env}/mongodb_sg_id"
}

data "aws_ssm_parameter" "catalogue_sg_id" {
  
  name = "/${var.Project}/${var.Env}/catalogue_sg_id"
}

data "aws_ssm_parameter" "user_sg_id" {
  
  name = "/${var.Project}/${var.Env}/user_sg_id"
}

data "aws_ssm_parameter" "redis_sg_id" {
  
  name = "/${var.Project}/${var.Env}/redis_sg_id"
}

data "aws_ssm_parameter" "rabbitmq_sg_id" {
  
  name = "/${var.Project}/${var.Env}/rabbitmq_sg_id"
}

data "aws_ssm_parameter" "mysql_sg_id" {
  
  name = "/${var.Project}/${var.Env}/mysql_sg_id"
}

data "aws_ssm_parameter" "cart_sg_id" {
  
  name = "/${var.Project}/${var.Env}/cart_sg_id"
}

data "aws_ssm_parameter" "shipping_sg_id" {
  
  name = "/${var.Project}/${var.Env}/shipping_sg_id"
}

data "aws_ssm_parameter" "payment_sg_id" {
  
  name = "/${var.Project}/${var.Env}/payment_sg_id"
}