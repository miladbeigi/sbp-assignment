resource "aws_iam_openid_connect_provider" "github" {
  url             = var.oidc_provider_url
  client_id_list  = var.oidc_provider_audiences
  thumbprint_list = var.thumbprint_list
}

resource "aws_iam_role" "app-infra-role" {
  name = "app-infra-role-${var.environment}"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.github.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "token.actions.githubusercontent.com:aud" : "sts.amazonaws.com"
          },
          "StringLike" : {
            "token.actions.githubusercontent.com:sub" : [for repo in var.app-infra-repos : "repo:${repo}"]
          }
        }
      }
    ]
  })
}

resource "aws_iam_role" "core-infra-role" {
  name = "core-infra-role-${var.environment}"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.github.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "token.actions.githubusercontent.com:aud" : "sts.amazonaws.com"
          },
          "StringLike" : {
            "token.actions.githubusercontent.com:sub" : [for repo in var.core-infra-repos : "repo:${repo}"]
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app-infra-policy-attachment" {
  role       = aws_iam_role.app-infra-role.name
  policy_arn = aws_iam_policy.app-infra-policy.arn
}

resource "aws_iam_role_policy_attachment" "app-infra-read-only-policy" {
  role       = aws_iam_role.app-infra-role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
resource "aws_iam_role_policy_attachment" "core-infra-policy-attachment" {
  role       = aws_iam_role.core-infra-role.name
  policy_arn = aws_iam_policy.core-infra-policy.arn
}

resource "aws_iam_role_policy_attachment" "core-infra-read-only-policy" {
  role       = aws_iam_role.core-infra-role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
