resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "dedicated"

  tags = {
    Name = var.name
    Client = var.client
    Env = var.env
    Provider = var.solution_provider
  }
}

# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "website-main-a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.name
    Client = var.client
    Env = var.env
    Provider = var.solution_provider
  }

  depends_on = [
    data.aws_availability_zones.available,
  ]
}

resource "aws_subnet" "website-main-b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-north-1b"

  tags = {
    Name = var.name
    Client = var.client
    Env = var.env
    Provider = var.solution_provider
  }
}

resource "aws_subnet" "website-main-c" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-north-1c"

  tags = {
    Name = var.name
    Client = var.client
    Env = var.env
    Provider = var.solution_provider
  }
}
