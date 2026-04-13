module "sg" {
   source = "../../terraform-aws-sg"
   Env = var.Env
   Project = var.Project 
   Component = var.Component
   vpc_id = local.vpc_id
}