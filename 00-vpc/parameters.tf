resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.Project}/${var.Env}/vpc"
  type = "String"
  value = module.vpc.vpc_id
}