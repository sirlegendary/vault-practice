variable "aws_region" {
  description = "AWS Region"
  default     = "eu-west-1"
}

variable "application_name" {
  default = "Vault-Consul-Server"
}

variable "instancetype" {
  description = "EC2 instance type"
  default     = "t2.micro"
}
