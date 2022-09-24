terraform {
  backend "remote" {
    organization = "legendary-org"
    workspaces {
      name = "vault-practice"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}


