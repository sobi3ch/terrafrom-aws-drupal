variable "client" {
  description = "Client we are working for"
  default     = "Eclectic"
  type        = string
}

variable "supplier" {
  description = "Copany which make acctual work"
  default     = "Allunel"
  type        = string
}

variable "name" {
  description = "Project name"
  type        = string
  default     = "Website"
}

variable "environment" {
  description = "Enviroment (dev/stage/prod/etc)"
  type        = string
  default     = "Development"
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
