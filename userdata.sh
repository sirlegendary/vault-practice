#!/bin/bash

# update
sudo apt-get update

# install unzip
sudo apt install unzip

# install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Add the HashiCorp GPG key as a trusted package-signing key
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

# Add the official HashiCorp Linux repository
sudo apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# Update the package index
sudo apt update

# install Vault and Consul
sudo apt install -y vault consul

# install Enterprise Vault and Consul
# sudo apt install -y vault-enterprise consul-enterprise

# install vault and consul via snap
# sudo snap install vault consul

# install & setup certbot
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo ufw allow 443
# sudo certbot certonly --register-unsafely-without-email --agree-tos --standalone -d ec2-52-211-45-94.eu-west-1.compute.amazonaws.com
# /etc/letsencrypt/live/$domain

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
sudo chown vault:vault /etc/vault.d/vault.hcl

sudo ./setup.sh