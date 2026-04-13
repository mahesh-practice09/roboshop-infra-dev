module "sg" {
   count = length(var.Component)
   source = "../../terraform-aws-sg"
   Env = var.Env
   Project = var.Project 
   Component = replace(var.Component[count.index], "_","-" )
   vpc_id = local.vpc_id
}