locals {
      common_tags = {
        Project = var.Project
        Terraform = true
        Env = var.Env
    }

    tags = merge(local.common_tags, 
    { Name = "${var.Project}-${var.Env}-Bastion"} )
     
}     