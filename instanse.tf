data "aws_ami" "latest-ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


data "template_file" "userdata" {
  template = file("${path.module}/userdata.sh")
  vars = {
    "bucket" = aws_s3_bucket.bucket.id
  }
}

resource "aws_instance" "server" {
  ami                         = "ami-0fa727183db909e1b"
  instance_type               = var.instancetype
  key_name                    = aws_key_pair.public_key.key_name
  iam_instance_profile        = aws_iam_instance_profile.instance_profile.name
  user_data                   = data.template_file.userdata.rendered
  vpc_security_group_ids      = [aws_security_group.securitygroup.id]
  associate_public_ip_address = true

  tags = {
    Name = var.application_name
  }
}