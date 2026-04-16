resource "aws_instance" "mongodb" {
   ami = data.aws_ami.devopsami.image_id
   instance_type = local.instance_type
   subnet_id = local.private_subnet_ids[0]
   vpc_security_group_ids = [ local.mongodbsg_id ]
   tags = merge(local.common_tags, 
    { Name = "${var.Project}-${var.Env}-mongodb"})      #    Roboshop-sbx-mongodb
}

resource "terraform_data" "mongodb_bootstrap" {
    triggers_replace = [aws_instance.mongodb.id]
    depends_on = [ aws_route53_record.mongodb ]

     provisioner "file" {
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
     }

     provisioner "remote-exec" {
      inline = [ "chmod +x /tmp/bootstrap.sh" ,
                 "sudo sh /tmp/bootstrap.sh mongodb" ]
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
   subnet_id = local.private_subnet_ids[0]
   vpc_security_group_ids = [ local.redissg_id ]
   tags = merge(local.common_tags, 
    { Name = "${var.Project}-${var.Env}-redis"})     #       Roboshop-sbx-redis
}

resource "terraform_data" "redis_bootstrap" {
    triggers_replace = [aws_instance.redis.id]
    depends_on = [ aws_route53_record.redis ]

     provisioner "file" {
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
     }

     provisioner "remote-exec" {
      inline = [ "chmod +x /tmp/bootstrap.sh" ,
                 "sudo sh /tmp/bootstrap.sh redis" ]
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
   subnet_id = local.private_subnet_ids[0]
   vpc_security_group_ids = [ local.rabbitmqsg_id ]
    tags = merge(local.common_tags, 
    { Name = "${var.Project}-${var.Env}-rabbitmq"})   #      Roboshop-sbx-rabbitmq
}

resource "terraform_data" "rabbitmq_bootstrap" {
    triggers_replace = [aws_instance.rabbitmq.id]
    depends_on = [ aws_route53_record.rabbitmq ]

     provisioner "file" {
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
     }

     provisioner "remote-exec" {
      inline = [ "chmod +x /tmp/bootstrap.sh" ,
                 "sudo sh /tmp/bootstrap.sh rabbitmq" ]
    }

    connection {
         type = "ssh"
         user = "ec2-user"
         password = "DevOps321"
         host = aws_instance.mysql.private_ip
    }
   
}

resource "aws_instance" "mysql" {
   ami = data.aws_ami.devopsami.image_id
   instance_type = local.instance_type
   subnet_id = local.private_subnet_ids[0]
   vpc_security_group_ids =  [ local.mysqlsg_id ]
   tags = merge(local.common_tags, 
    { Name = "${var.Project}-${var.Env}-mysql"})   #      Roboshop-sbx-mysql

}

resource "terraform_data" "mysql_bootstrap" {
    triggers_replace = [aws_instance.mysql.id]
    depends_on = [ aws_route53_record.mysql ]

     provisioner "file" {
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
     }

     provisioner "remote-exec" {
      inline = [ "chmod +x /tmp/bootstrap.sh" ,
                 "sudo sh /tmp/bootstrap.sh mysql" ]
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
  name    = "${var.Project}-${var.Env}-mongodb.${var.domain_name}"      #roboshop-sbx-mongodb.daws88s.shop
  type    = "A"
  ttl     = 2
  records = [ aws_instance.mongodb.private_ip ]
  allow_overwrite = true
}

resource "aws_route53_record" "redis" {
  zone_id = var.zone_id
  name    = "${var.Project}-${var.Env}-redis.${var.domain_name}"        #roboshop-sbx-redis.daws88s.shop
  type    = "A"
  ttl     = 2
  records = [ aws_instance.redis.private_ip ]
  allow_overwrite = true
}

resource "aws_route53_record" "rabbitmq" {
  zone_id = var.zone_id
  name    = "${var.Project}-${var.Env}-rabbitmq.${var.domain_name}"     #roboshop-sbx-rabbitmq.daws88s.shop
  type    = "A"
  ttl     = 2
  records = [ aws_instance.rabbitmq.private_ip ]
  allow_overwrite = true
}

resource "aws_route53_record" "mysql" {
  zone_id = var.zone_id
  name    = "${var.Project}-${var.Env}-mysql.${var.domain_name}"       #roboshop-sbx-mysql.daws88s.shop
  type    = "A"
  ttl     = 2
  records = [ aws_instance.mysql.private_ip ]
  allow_overwrite = true
}