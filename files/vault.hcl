api_addr = "https://${public_ip}:8200"
cluster_addr = "https://${public_ip}:8201"
cluster_name = "${application_name}-${aws_region}"

storage "raft" {
  path    = "/opt/vault/data"
  node_id = "node-${application_name}-${aws_region}.walesalami.com"
  retry_join {
    auto_join = "provider=aws region=${aws_region} tag_key=vault tag_value=${aws_region}"
  }
}

listener "tcp" {
 address = "0.0.0.0:8200"
 cluster_address = "0.0.0.0:8201"
 tls_disable = 1
 tls_cert_file = "/opt/vault/tls/ca.crt.pem"
 tls_key_file = "/opt/vault/tls/vault.key.pem"
 tls_client_ca_file = "/opt/vault/tls/vault-ca.pem"
}

seal "awskms" {
  region = "${aws_region}"
  kms_key_id = "${kms_key_id}"
}

ui = true
log_level = "INFO"