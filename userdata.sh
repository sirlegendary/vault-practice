#! /bin/bash

# update
sudo apt-get update

# Add the HashiCorp GPG key as a trusted package-signing key
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

# Add the official HashiCorp Linux repository
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# Update the package index
sudo apt update

# install Vault and Consul
sudo apt install -y vault consul

# install Enterprise Vault and Consul
# sudo apt install -y vault-enterprise consul-enterprise

# Set the file ownership of the CA and certificate files to be owned by root
sudo chown root:root /opt/vault/tls/vault.crt.pem /opt/vault/tls/ca.crt.pem

# Set the file group ownership of the private key to allow the Vault service to read the file
sudo chown root:vault /opt/vault/tls/vault.key.pem

# Set the file permissions of the CA and certificate files to be world-readable
sudo chmod 0644 /opt/vault/tls/vault.crt.pem /opt/vault/tls/ca.crt.pem

# Set the file permissions of the private key file to be readable only by the Vault service
sudo chmod 0640 /opt/vault/tls/vault.key.pem

# To ensure TLS connection can be validated, first set the VAULT_CACERT environment variable to the path of the CA root certificate
export VAULT_CACERT=/opt/vault/tls/vault-ca.pem

# set vault address
export VAULT_ADDR=http://$(hostname):8200

# create vault directory
sudo mkdir /etc/vault.d

# create directory that raft storage backend uses
mkdir -p /opt/vault/data
sudo chown -R vault /opt/vault/data

#### create/move vault.hcl into /etc/vault.d/

# mv the vault.service file into systemd
# sudo mv vault.service /etc/systemd/system/

# Enable the systemd vault.service unit to allow the Vault service to start
# sudo systemctl enable vault.service

# Start the Vault service
# sudo systemctl start vault.service

# Check the status of the Vault service to ensure it is running.
# sudo systemctl status vault.service

# logs
# sudo journalctl -u vault