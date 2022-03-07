resource "aws_iam_user" "developer_bob" {
  name = "developer_bob"
}

resource "aws_iam_access_key" "developer_bob_access_key" {
  user = aws_iam_user.developer_bob.name
}

resource "aws_iam_user_policy_attachment" "AmazonS3FullAccess" {
  user       = aws_iam_user.developer_bob.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_user_policy_attachment" "IAMReadOnlyAccess" {
  user       = aws_iam_user.developer_bob.name
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}

resource "aws_iam_user_policy_attachment" "AWSLambda_ReadOnlyAccess" {
  user       = aws_iam_user.developer_bob.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_ReadOnlyAccess"
}