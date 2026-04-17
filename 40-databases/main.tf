resource "aws_instance" "mongodb" {
   ami = data.aws_ami.devopsami.image_id
   instance_type = local.instance_type
   subnet_id = local.db_private_subnet_ids[0]
   vpc_security_group_ids = [ local.mongodbsg_id ]
   tags = merge(local.common_tags, 
    { Name = "${var.Project}-${var.environment}-mongodb"})      #    Roboshop-sbx-mongodb
}

resource "terraform_data" "mongodb_bootstrap" {
    triggers_replace = [aws_instance.mongodb.id]
  

     provisioner "file" {
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
     }

     provisioner "remote-exec" {
      inline = [ "chmod +x /tmp/bootstrap.sh" ,
                 "sudo sh /tmp/bootstrap.sh mongodb ${var.environment}" ]
    }

    connection {
         type = "ssh"
         user = "ec2-user"
         password = "DevOps321"
         host = aws_instance.mongodb.private_ip
    }
   
}

resource "aws_instance" "redis" {
   ami = data.aws_ami.devopsami.image_id
   instance_type = local.instance_type
   subnet_id = local.db_private_subnet_ids[0]
   vpc_security_group_ids = [ local.redissg_id ]
   tags = merge(local.common_tags, 
    { Name = "${var.Project}-${var.environment}-redis"})     #       Roboshop-sbx-redis
}

resource "terraform_data" "redis_bootstrap" {
    triggers_replace = [aws_instance.redis.id]
  

     provisioner "file" {
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
     }

     provisioner "remote-exec" {
      inline = [ "chmod +x /tmp/bootstrap.sh" ,
                 "sudo sh /tmp/bootstrap.sh redis ${var.environment}" ]
    }

    connection {
         type = "ssh"
         user = "ec2-user"
         password = "DevOps321"
         host = aws_instance.redis.private_ip
    }
   
}

resource "aws_instance" "rabbitmq" {
   ami = data.aws_ami.devopsami.image_id
   instance_type = local.instance_type
   subnet_id = local.db_private_subnet_ids[0]
   vpc_security_group_ids = [ local.rabbitmqsg_id ]
    tags = merge(local.common_tags, 
    { Name = "${var.Project}-${var.environment}-rabbitmq"})   #      Roboshop-sbx-rabbitmq
}

resource "terraform_data" "rabbitmq_bootstrap" {
    triggers_replace = [aws_instance.rabbitmq.id]
   

     provisioner "file" {
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
     }

     provisioner "remote-exec" {
      inline = [ "chmod +x /tmp/bootstrap.sh" ,
                 "sudo sh /tmp/bootstrap.sh rabbitmq ${var.environment}" ]
    }

    connection {
         type = "ssh"
         user = "ec2-user"
         password = "DevOps321"
         host = aws_instance.rabbitmq.private_ip
    }
   
}

resource "aws_instance" "mysql" {
   ami = data.aws_ami.devopsami.image_id
   iam_instance_profile = aws_iam_instance_profile.mysql.name
   instance_type = local.instance_type
   subnet_id = local.db_private_subnet_ids[0]
   vpc_security_group_ids =  [ local.mysqlsg_id ]
   tags = merge(local.common_tags, 
    { Name = "${var.Project}-${var.environment}-mysql"})   #      Roboshop-sbx-mysql

}

resource "terraform_data" "mysql_bootstrap" {
    triggers_replace = [aws_instance.mysql.id]
  

     provisioner "file" {
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
     }

     provisioner "remote-exec" {
      inline = [ "chmod +x /tmp/bootstrap.sh" ,
                 "sudo sh /tmp/bootstrap.sh mysql ${var.environment}" ]
    }

    connection {
         type = "ssh"
         user = "ec2-user"
         password = "DevOps321"
         host = aws_instance.mysql.private_ip
    }
   
}

resource "aws_route53_record" "mongodb" {
  zone_id = var.zone_id
  name    = "${var.Project}-${var.environment}-mongodb.${var.domain_name}"      #roboshop-sbx-mongodb.daws88s.shop
  type    = "A"
  ttl     = 2
  records = [ aws_instance.mongodb.private_ip ]
  allow_overwrite = true
}

resource "aws_route53_record" "redis" {
  zone_id = var.zone_id
  name    = "${var.Project}-${var.environment}-redis.${var.domain_name}"        #roboshop-sbx-redis.daws88s.shop
  type    = "A"
  ttl     = 2
  records = [ aws_instance.redis.private_ip ]
  allow_overwrite = true
}

resource "aws_route53_record" "rabbitmq" {
  zone_id = var.zone_id
  name    = "${var.Project}-${var.environment}-rabbitmq.${var.domain_name}"     #roboshop-sbx-rabbitmq.daws88s.shop
  type    = "A"
  ttl     = 2
  records = [ aws_instance.rabbitmq.private_ip ]
  allow_overwrite = true
}

resource "aws_route53_record" "mysql" {
  zone_id = var.zone_id
  name    = "${var.Project}-${var.environment}-mysql.${var.domain_name}"       #roboshop-sbx-mysql.daws88s.shop
  type    = "A"
  ttl     = 2
  records = [ aws_instance.mysql.private_ip ]
  allow_overwrite = true
}