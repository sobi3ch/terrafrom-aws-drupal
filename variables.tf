locals {
  client = "Eclectic"
  solution_provider = "Allunel"
}

locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Client   = local.client
    Provider = local.solution_provider
  }
}

variable "name" {
  type = string
  default = "Website"
}

variable "env" {
  type = string
  default = "Development"
}
