terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.43"
    }
  }

  required_version = "~> 1.7"
}

provider "aws" {
  region = "eu-north-1"
}

