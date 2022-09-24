# resource "tls_private_key" "generate_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "aws_key_pair" "public_key" {
#   key_name   = var.application_name
#   public_key = tls_private_key.generate_key.public_key_openssh
# }

data "template_file" "public_key" {
  template = file("${path.module}/public_key.txt")
}

resource "aws_key_pair" "public_key" {
  key_name   = var.application_name
  public_key = data.template_file.public_key.rendered
}