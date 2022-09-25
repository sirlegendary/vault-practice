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

data "template_file" "vault_raft_config_file" {
  template = file("${path.module}/files/${var.vault_config_file}")
  vars = {
    public_ip        = aws_instance.server.public_dns
    application_name = var.application_name
    aws_region       = var.aws_region
    kms_key_id       = aws_kms_key.kms.key_id
  }
}

data "template_file" "vault_service" {
  template = file("${path.module}/files/${var.vault_service_file}")
}

data "template_file" "vault_setup_script" {
  template = file("${path.module}/files/${var.vault_setup_script}")
  vars = {
    public_ip = aws_instance.server.public_dns
  }
}

resource "aws_s3_object" "vault_raft_config_file" {
  bucket  = aws_s3_bucket.bucket.id
  key     = var.vault_config_file
  content = data.template_file.vault_raft_config_file.rendered
}

resource "aws_s3_object" "vault_service" {
  bucket  = aws_s3_bucket.bucket.id
  key     = var.vault_service_file
  content = data.template_file.vault_service.rendered
}

resource "aws_s3_object" "vault_setup_script" {
  bucket  = aws_s3_bucket.bucket.id
  key     = var.vault_setup_script
  content = data.template_file.vault_setup_script.rendered
}
