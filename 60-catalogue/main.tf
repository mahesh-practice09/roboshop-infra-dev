resource "aws_instance" "catalogue" {
   ami = data.aws_ami.devopsami.image_id
   instance_type = local.instance_type
   subnet_id = local.private_subnet_ids[0]
   vpc_security_group_ids = [ local.cataloguesg_id ]
   tags = merge(local.common_tags, 
    { Name = "${var.Project}-${var.environment}-catalogue"})      #    Roboshop-sbx-mongodb
}

resource "terraform_data" "catalogue_bootstrap" {
    triggers_replace = [aws_instance.catalogue.id]
  

     provisioner "file" {
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
     }

     provisioner "remote-exec" {
      inline = [ "chmod +x /tmp/bootstrap.sh" ,
                 "sudo sh /tmp/bootstrap.sh catalogue ${var.environment}" ]
    }

    connection {
         type = "ssh"
         user = "ec2-user"
         password = "DevOps321"
         host = aws_instance.catalogue.private_ip
    }
   
}