data "http" "my_public_ip" {
  url = "https://ipv4.icanhazip.com"
}

data "aws_ssm_parameter" "bastion_sg_id" {
  
  name = "/${var.Project}/${var.Env}/Bastion_sg_id"
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