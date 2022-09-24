data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.aws_region}-${data.aws_caller_identity.current.account_id}-${var.application_name}"

  tags = {
    Name = var.application_name
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

# moving files content