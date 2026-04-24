module component {
   for_each = var.component
   source = "../../terraform-roboshop-component"
   component = each.key
   rule_priority = each.value.rule_priority
   }