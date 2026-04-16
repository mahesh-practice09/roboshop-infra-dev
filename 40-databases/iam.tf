resource "aws_iam_role" "mysqlrole" {
  name = "${var.Project}-${var.Env}-mysql"

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
   tags = merge(local.common_tags ,{Name = local.mysql-role-name})
}

resource "aws_iam_policy" "sqlpolicy" {
  name        = local.mysql-role-policy
  
   policy = file("mysql-iam-policy.json")
}

resource "aws_iam_role_policy_attachment" "mysql_attach_policy" {
  role = aws_iam_role.mysqlrole.name
  policy_arn = aws_iam_policy.sqlpolicy.arn
}

resource "aws_iam_instance_profile" "mysqlprofile" {
   name =  "${var.Project}-${var.Env}-mysql-profile"
   role = aws_iam_role.mysqlrole.name
}