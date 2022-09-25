#! /bin/bash

# # Set the file ownership of the CA and certificate files to be owned by root
# sudo chown root:root /opt/vault/tls/vault.crt.pem /opt/vault/tls/ca.crt.pem

# # Set the file group ownership of the private key to allow the Vault service to read the file
# sudo chown root:vault /opt/vault/tls/vault.key.pem

# # Set the file permissions of the CA and certificate files to be world-readable
# sudo chmod 0644 /opt/vault/tls/vault.crt.pem /opt/vault/tls/ca.crt.pem

# # Set the file permissions of the private key file to be readable only by the Vault service
# sudo chmod 0640 /opt/vault/tls/vault.key.pem

# To ensure TLS connection can be validated, first set the VAULT_CACERT environment variable to the path of the CA root certificate
# export VAULT_CACERT=/opt/vault/tls/ca.crt.pem

systemctl_setup () {
    echo "##### systemctl setup #####"
    # Enable the systemd vault.service unit to allow the Vault service to start
    sudo systemctl enable vault.service

    # Start the Vault service
    sudo systemctl start vault.service
} 

set_vault_exports () {
    echo "##### set exports #####"
    # set vault address
    echo "export VAULT_ADDR=http://${public_ip}:8200" >> /etc/environment
    source /etc/environment
}

vault_auto_complete () {
    echo "##### Install vault auto complete #####"
    vault -autocomplete-install || true
    complete -C /usr/bin/vault vault || true
}

systemctl_setup
set_vault_exports 
#vault_auto_complete 