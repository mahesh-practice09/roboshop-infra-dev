resource "aws_iam_role" "mysql" {
  name = local.mysql_role_name

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
   tags = merge(local.common_tags ,{Name = local.mysql_role_name})
}

resource "aws_iam_policy" "sql" {
  name        = local.mysql_role_policy
  
   policy = file("mysql-iam-policy.json")
}

resource "aws_iam_role_policy_attachment" "mysql" {
  role = aws_iam_role.mysqlrole.name
  policy_arn = aws_iam_policy.sql.arn
}

resource "aws_iam_instance_profile" "mysql" {
   name =  "${var.Project}-${var.Env}-mysql-profile"
   role = aws_iam_role.mysql.name
}