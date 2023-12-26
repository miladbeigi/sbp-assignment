resource "aws_iam_role" "app-runner-service-role" {
  name               = "app-runner-service-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "build.apprunner.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

data "aws_iam_policy" "AWSAppRunnerServicePolicyForECRAccess" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.app-runner-service-role.name
  policy_arn = data.aws_iam_policy.AWSAppRunnerServicePolicyForECRAccess.arn
}
