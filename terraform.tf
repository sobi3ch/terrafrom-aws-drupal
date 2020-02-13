provider "aws" {
  version = "~> 2.44"
  region  = "eu-north-1"
}

terraform {
    backend "s3" {
        bucket  = "terraform382938"
        encrypt = true
        key     = "terraform.tfstate"
        region  = "eu-north-1"
    }
}
