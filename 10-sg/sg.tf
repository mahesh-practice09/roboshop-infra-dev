module "sg" {
   count = length(var.Component)
   source = "../../terraform-aws-sg"
   environment = var.environment
   project = var.project 
   vpc_id = local.vpc_id
   sg_name = replace(var.Component[count.index], "_","-" )
}