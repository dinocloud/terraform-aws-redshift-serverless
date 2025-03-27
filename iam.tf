# Create IAM role for Redshift Data API
# if create_default_iam_role is true
# https://docs.aws.amazon.com/redshift/latest/mgmt/data-api.html

data "aws_caller_identity" "this" {}

data "aws_region" "this" {}

data "aws_iam_policy_document" "this" {
  statement {
    effect    = "Allow"
    actions   = ["redshift-data:*"]
    resources = []
  }
}

resource "aws_iam_role" "this" {
  for_each = var.create_default_iam_role ? toset([var.cluster_name]) : []

  name = try(var.default_iam_role_name, "redshiftserverless-${var.cluster_name}")
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.this.account_id}:root"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}
