variable "client" {
  default = "Eclectic"
  type    = string
}

variable "supplier" {
  default = "Allunel"
  type    = string
}

variable "name" {
  type    = string
  default = "Website"
}

variable "environment" {
  type    = string
  default = "Development"
}

locals {
  client            = var.client
  solution_provider = var.supplier

  # Common tags to be assigned to all resources
  common_tags = {
    Client   = local.client
    Provider = local.solution_provider
  }
}
