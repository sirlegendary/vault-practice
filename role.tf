resource "aws_iam_role" "role" {
  name = "${var.application_name}-role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

data "aws_iam_policy_document" "role_policy_doc" {
  statement {
    sid = "Permissions"

    actions = [
      "kms:*",
      "s3:*",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "role_policy" {
  name   = "${var.application_name}-policy"
  policy = data.aws_iam_policy_document.role_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "role_policy_attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.role_policy.arn
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.application_name}-profile"
  role = aws_iam_role.role.name
}