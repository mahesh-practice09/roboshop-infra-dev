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

resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  depends_on = [ terraform_data.catalogue_bootstrap ]
}

resource "aws_ami_from_instance" "catalogue" {
  name               = "${var.Project}-${var.environment}-catalogue"
  source_instance_id = aws_ec2_instance_state.catalogue.id

  depends_on = [ aws_ec2_instance_state.catalogue ]
}


resource "aws_lb_target_group" "catalogue" {
   name =  "${var.Project}-${var.environment}-catalogue-tg"
   port = 8080
   protocol = "HTTP"
   vpc_id = data.aws_ssm_parameter.vpc_id.value
   deregistration_delay = 60
   health_check {
      protocol = "HTTP"
      path = "/health"
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 5
      interval = 10
      matcher = "200-299"
      port = 8080
   } 
}

# resource "aws_lb_target_group_attachment" "catalogue" {
#    target_group_arn = aws_lb_target_group.catalogue.target_group_arn 
#    target_id = aws_lb_target_group.catalogue.id
# }

resource "aws_launch_template" "catalogue" {
  name =  "${var.Project}-${var.environment}-catalogue"
  vpc_security_group_ids = [ local.cataloguesg_id ]
  instance_initiated_shutdown_behavior = "terminate"
  update_default_version = true
  image_id = aws_ami_from_instance.catalogue.id
  instance_type = local.instance_type
  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 20
    }
  }

  tag_specifications {
    resource_type = "instance"

     tags = merge(local.common_tags, 
    { Name = "${var.Project}-${var.environment}-catalogue"})   
  
  }
  tag_specifications {
    resource_type = "volume"

     tags = merge(local.common_tags, 
    { Name = "${var.Project}-${var.environment}-catalogue"})   
  
  }
  }

  resource "aws_autoscaling_group" "catalogue" {
  name =  "${var.Project}-${var.environment}-catalogue"
  max_size                  = 10
  min_size                  = 1
  health_check_grace_period = 120
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = false
  launch_template {
    id = aws_launch_template.catalogue.id
    version = "$Latest"
  }
  vpc_zone_identifier       = [local.private_subnet_ids[0]]
  target_group_arns = [ aws_lb_target_group.catalogue.arn ]

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = [ "launch_template" ]
  }

  dynamic "tag" {
    for_each = merge(local.common_tags, 
    { Name = "${var.Project}-${var.environment}-catalogue"})   
    content {
    key                 = tag.key
    value               = tag.value
    propagate_at_launch = true
    }
  }

  timeouts {
    delete = "15m"
  }

  }


resource "aws_autoscaling_policy" "catalogue" {
  name =  "${var.Project}-${var.environment}-catalogue"
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  estimated_instance_warmup = 120
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 70.0
  }
  
}

resource "aws_lb_listener_rule" "catalogue" {
  listener_arn = data.aws_ssm_parameter.alb_listener_arn.value
  priority     = 10
  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.catalogue.arn
  }
  condition {
     host_header {
        values = [ "catalogue.backend-${var.environment}-alb.${var.domain_name}" ]
        #catalogue.backend-alb.sbx.daws88s.shop
    }
     }
  }


resource "terraform_data" "catalogue_delete" {
   depends_on = [ aws_autoscaling_policy.catalogue ]
   triggers_replace = [ aws_instance.catalogue.id ]
   provisioner "local-exec" {
      command = " aws ec2 terminate-instances --instance-ids ${aws_instance.catalogue.id}"
   }
}