resource "aws_iam_role" "lambda_role_for_development" {
  name = "lambda_role_for_development"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "dev_iam_admin" {
  name        = "dev_iam_admin"
  description = "policy for pentest scenario"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "iam:ListPolicies",
                "iam:AddUserToGroup",
                "iam:UpdateUser",
                "iam:ListRoles",
                "iam:ListUsers",
                "iam:ListGroups"
            ],
            "Resource": "*"
        },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "AWSLambdaBasicExecutionRole" {
  role       = aws_iam_role.lambda_role_for_development.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "AmazonS3FullAccess" {
  role       = aws_iam_role.lambda_role_for_development.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "dev_iam_admin" {
  role       = aws_iam_role.lambda_role_for_development.name
  policy_arn = aws_iam_policy.dev_iam_admin.arn
}

resource "aws_lambda_function" "scan_tar_from_bucket" {
  filename      = "lambda_function.zip"
  function_name = "scan_tar_from_bucket"
  role          = aws_iam_role.lambda_role_for_development.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = filebase64sha256("lambda_function.zip")

  runtime = "python3.7"

}