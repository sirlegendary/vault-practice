api_addr = "http://${public_ip}:8200"
cluster_addr = "http://${public_ip}:8201"
cluster_name = "${application_name}-${aws_region}"

storage "raft" {
  path    = "/opt/vault/data"
  node_id = "node-${application_name}-${aws_region}.walesalami.com"
  retry_join {
    auto_join = "provider=aws region=${aws_region} tag_key=vault tag_value=${aws_region}"
  }
}

listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_disable = "true"
  tls_cert_file = "/opt/vault/tls/tls.crt"
  tls_key_file  = "/opt/vault/tls/tls.key"
}

seal "awskms" {
  region = "${aws_region}"
  kms_key_id = "${kms_key_id}"
}

ui = true
log_level = "INFO"