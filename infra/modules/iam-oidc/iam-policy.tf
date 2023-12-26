## Description: IAM policy for the app-infra role
## To keep the policy readable, use separate statements with proper SID for groups of actions
## that are relavant to AWS services.

resource "aws_iam_policy" "app-infra-policy" {
  name = "app-infra-policy-${var.environment}"
  policy = templatefile("${path.module}/app-infra-policy-${var.environment}.json", {
    environment                         = "${var.environment}"
    code-pipeline-bucket-name           = "${var.code-pipeline-bucket-name}"
    terraform-state-bucket-name         = "${var.terraform-state-bucket-name}"
    terraform-state-dynamodb-table-name = "${var.terraform-state-dynamodb-table-name}"
  })
}

## Description: IAM policy for the core-infra role
## To keep the policy readable, use separate statements with proper SID for groups of actions
## that are relavant to AWS services.

resource "aws_iam_policy" "core-infra-policy" {
  name = "core-infra-policy-${var.environment}"
  policy = templatefile("${path.module}/core-infra-policy-${var.environment}.json", {
    environment                         = "${var.environment}"
    code-pipeline-bucket-name           = "${var.code-pipeline-bucket-name}"
    terraform-state-bucket-name         = "${var.terraform-state-bucket-name}"
    terraform-state-dynamodb-table-name = "${var.terraform-state-dynamodb-table-name}"
  })
}
