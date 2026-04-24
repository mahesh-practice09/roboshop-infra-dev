variable "component" {
  default = {
    catalogue = {
        rule_priority = 10 
    }

    user = {
        rule_priority = 20

    }

    frontend = {
        rule_priority = 30
    }
  }
}

variable "environment" {
   default = "sbx"
}

variable "Project" {
  default = "roboshop"
}