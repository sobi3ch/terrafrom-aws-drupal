terraform {
  backend "s3" {
    bucket  = "terraform382938"
    encrypt = true
    key     = "terraform.tfstate"
    region  = "eu-north-1"
  }
}