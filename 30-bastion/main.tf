resource "aws_iam_role" "bastionrole" {
  name = "${var.Project}-${var.Env}-Bastion"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = local.tags
}


resource "aws_iam_role_policy_attachment" "bastion_attach_policy" {
  role = aws_iam_role.bastionrole.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


resource "aws_iam_instance_profile" "bastionprofile" {
   name =  "${var.Project}-${var.Env}-Bastion-profile"
role = aws_iam_role.bastionrole.name
}


resource "aws_instance" "bastion" {
   ami = data.aws_ami.devopsami.image_id
   instance_type = var.instance_type
   iam_instance_profile = aws_iam_instance_profile.bastionprofile.name
   subnet_id = local.public_subnet_ids[0]
   vpc_security_group_ids = [ local.bastionsg_id ]
   user_data = file("bastion.sh")
   tags = merge(local.common_tags, 
    { Name = "${var.Project}-${var.Env}-bastion"})     
   root_block_device {
         volume_size = 50
         volume_type = "gp3"
         tags = merge(local.common_tags, 
    { Name = "${var.Project}-${var.Env}-bastion"})  
   }
}

resource "terraform_data" "bootstrap" {
  triggers_replace = [ aws_instance.bastion.id ]
    provisioner "file" {
      source = "bootstrap.sh"
      destination = "/tmp/bootstrap.sh"
    }
    connection {
         type = "ssh"
         user = "ec2-user"
         password = "DevOps321"
         host = aws_instance.bastion.public_ip
    }
    provisioner "remote-exec" {
      inline = [ "chmod +x /tmp/bootstrap.sh" ,
                 "sudo sh /tmp/bootstrap.sh" ]
    }
}