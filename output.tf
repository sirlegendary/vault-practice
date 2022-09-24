# output "private_key" {
#   value     = tls_private_key.generate_key.private_key_pem
#   sensitive = true
# }

output "ssh_login" {
  value = "ssh ubuntu@${aws_instance.server.public_ip}"
}