variable "tags" {
  description = "Default tags are empty"
  type        = map
  default     = {}
}

variable "name" {
  description = "Name of an infrastracture"
  type        = string
}

variable "environment" {
  description = "Name of an environment"
  type        = string
}

variable "client" {
  description = "Options: In case we have particular client we can name it here"
  type        = string
  default     = ""
}

variable "supplier" {
  description = "Optional: Your full name, name of your company or enything that's indentify creator of this infrastructure"
  type        = string
  default     = ""
}



locals {
  key_name = var.client == "" ? format("drupal-%s", lower(var.name)) : format("drupal-%s-%s", lower(var.name), lower(var.client))
}

locals {
  # client = var.client
  # solution_provider = var.provider

  # Common tags to be assigned to all resources
  common_tags = {
    Name        = var.name
    Environment = var.environment
  }
}
