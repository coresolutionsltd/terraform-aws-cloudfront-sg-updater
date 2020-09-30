data "aws_iam_policy_document" "lambda_trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "lambda.amazonaws.com",
      ]
    }
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name = var.name
  tags = var.tags
}

resource "aws_iam_role" "this" {
  name_prefix        = "lambda-cloudfront"
  assume_role_policy = data.aws_iam_policy_document.lambda_trust_policy.json
  tags               = var.tags
}

data "aws_iam_policy_document" "lambda_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*"]

  }
  statement {
    actions = [
      "iam:GetRolePolicy",
      "iam:ListGroupPolicies",
      "ec2:DescribeSecurityGroups",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupIngress"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "this" {
  name   = "lambda-cloudfront-policy"
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.lambda_policy.json
}

resource "aws_lambda_function" "updater" {
  function_name = var.name
  filename      = "${path.module}/lambda.zip"
  handler       = "main.lambda_handler"
  role          = aws_iam_role.this.arn
  runtime       = "python3.7"
  timeout       = 60
  tags          = var.tags
}

resource "aws_lambda_permission" "with_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.updater.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = "arn:aws:sns:us-east-1:806199016981:AmazonIpSpaceChanged"
}
