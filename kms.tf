resource "aws_kms_key" "kms" {}

resource "aws_kms_alias" "a" {
  name          = "alias/${var.application_name}"
  target_key_id = aws_kms_key.kms.key_id
}