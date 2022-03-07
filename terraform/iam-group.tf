resource "aws_iam_group" "entwickler-admin" {
  name = "entwickler-admin"
}

resource "aws_iam_group_policy_attachment" "AdministratorAccess" {
  group      = aws_iam_group.entwickler-admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}