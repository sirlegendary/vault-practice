#! /bin/bash

# update
sudo apt-get update
sleep 5 # to fix: https://itsfoss.com/could-not-get-lock-error/

# Add the HashiCorp GPG key as a trusted package-signing key
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

# Add the official HashiCorp Linux repository
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sleep 5

# Update the package index
sudo apt update
sleep 5

# install Vault and Consul
sudo apt install -y vault consul

# install Enterprise Vault and Consul
# sudo apt install -y vault-enterprise consul-enterprise

# create vault directory
sudo mkdir /etc/vault.d

# create directory that raft storage backend uses
mkdir -p /opt/vault/data
sudo chown -R vault /opt/vault/data

# download vault files from s3
aws s3 cp s3://${bucket}/vault.hcl .
aws s3 cp s3://${bucket}/vault.service .
aws s3 cp s3://${bucket}/setup.sh .

chmod +x setup.sh

# mv the vault.service file into systemd
sudo mv vault.service /etc/systemd/system/

# mv the vault.hcl file into systemd
sudo mv vault.hcl /etc/vault.d/

sudo ./setup.sh




