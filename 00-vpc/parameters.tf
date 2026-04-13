resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.Project}/${var.Env}/vpc"
  type = "String"
  value = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.Project}/${var.Env}/public_subnet_ids"
  type = "StringList"
  value = join(",",module.vpc.public_subnet_ids)
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.Project}/${var.Env}/private_subnet_ids"
  type = "String"
  value = join(",",module.vpc.private_subnet_ids)
}

resource "aws_ssm_parameter" "db_private_subnet_ids" {
  name  = "/${var.Project}/${var.Env}/db_private_subnet_ids"
  type = "String"
  value = join(",",module.vpc.db_private_subnet_ids)
}