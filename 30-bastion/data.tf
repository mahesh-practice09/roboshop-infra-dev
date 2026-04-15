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


data "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.Project}/${var.Env}/public_subnet_ids"
}


data "aws_ssm_parameter" "bastion_sg_id" {
  
  name = "/${var.Project}/${var.Env}/bastion_sg_id"
}