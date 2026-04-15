

  variable "Project" {
    default = "roboshop"
  }

  variable "Env" {
    default = "sbx"
  }

  # variable "Component" {
  #   default = "Mongodb"
  # }

  variable "Component" {
    type = list 
    default = [
       #databases

       "mongodb" , "redis" ,"mysql" , "rabbitmq",

       #Backend

       "catalogue" , "user" , "cart" , "shipping" , "payment",

       #frontend

       "frontend",

       #ALB

      "backend_alb" ,"frontend_alb",

      "bastion"
    ]
  }