variable "aws_region" {
  description = "AWS Region"
  default     = "eu-west-1"
}

variable "application_name" {
  default = "vault-consul-server"
}

variable "instancetype" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "vault_config_file" {
  default = "vault.hcl"
}

variable "vault_service_file" {
  default = "vault.service"
}

variable "vault_setup_script" {
  default = "setup.sh"
}