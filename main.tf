terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 2.70"
        }
    }
}

data "template_file" "iam-policy-template" {
    template = file("templates/policy.tpl")

    vars = {
        resource-name = aws_s3_bucket.s3-bucket.arn
    }
}

data "local_file" "pgp_key" {
    filename = var.pgp_key_path
}

locals {
    iam_user_name = var.iam_user_name != "" ? var.iam_user_name : var.bucket
    iam_policy_name = var.iam_policy_name != "" ? var.iam_policy_name : "s3-upload-${var.bucket}"
}

provider "aws" {
    profile = "default"
    region  = var.region
}

resource "aws_iam_user" "iam-user" {
    name = local.iam_user_name
}

resource "aws_iam_access_key" "iam-user-access-key" {
  user = aws_iam_user.iam-user.name
  pgp_key = data.local_file.pgp_key.content_base64
}

resource "aws_iam_user_policy" "iam-user-policy-s3" {
    name = local.iam_policy_name
    user = aws_iam_user.iam-user.name

    policy = data.template_file.iam-policy-template.rendered
}

resource "aws_s3_bucket" "s3-bucket" {
    bucket  = var.bucket
    acl     = "public-read"

    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["GET", "PUT", "POST"]
        allowed_origins = var.allowed_origins
        expose_headers  = ["ETag"]
        max_age_seconds = 3000
    }
}

output "iam_access_key_id" {
    value = aws_iam_access_key.iam-user-access-key.id
}
output "iam_access_key_secret" {
    value = aws_iam_access_key.iam-user-access-key.encrypted_secret
}
