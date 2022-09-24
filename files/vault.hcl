api_addr = "https://ip-172-31-39-166.eu-west-1.compute.internal:8200"
cluster_addr = "https://ip-172-31-39-166.eu-west-1.compute.internal:8201"
cluster_name = "vault-prod-eu-west-1"

storage "raft" {
  path    = "/opt/vault/data"
  node_id = "node-vault-prod-eu-west-1.walesalami.com"
  retry_join {
    auto_join = "provider=aws region=eu-west-1 tag_key=vault tag_value=eu-west-1"
  }
}

listener "tcp" {
 address = "0.0.0.0:8200"
 tls_cert_file = "/opt/vault/tls/ca.crt.pem"
 tls_key_file = "/opt/vault/tls/vault.key.pem"
 tls_client_ca_file = "/opt/vault/tls/vault-ca.pem"
}

seal "awskms" {
  region = "eu-west-1"
  kms_key_id = "0abb9240-924d-4e78-9309-64f108f967a0"
}

ui = true
log_level = "INFO"