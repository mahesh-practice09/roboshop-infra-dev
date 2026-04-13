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