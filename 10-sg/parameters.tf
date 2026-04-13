resource "aws_ssm_parameter" "sg_id" {
  count = length(var.Component)
  name  = "/${var.Project}/${var.Env}/${var.Component[count.index]}_sg_id"
  type = "String"
  value = module.sg[count.index].sg_id
}