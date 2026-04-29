data "aws_ami" "devopsami" {
  most_recent = true
  owners      = ["679593333241"] # Canonical's AWS Account ID

  filter {
    name   = "name"
    values = ["OpenVPN Access Server Community Image-fe8020db-5343-4c43-9e65-5ed4a825c931"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


data "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.Project}/${var.environment}/public_subnet_ids"
}


data "aws_ssm_parameter" "openvpn_sg_id" {
  
  name = "/${var.Project}/${var.environment}/openvpn_sg_id"
}