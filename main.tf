module "networking" {
  source = "./modules/networking"
  name = "Website"

  tags = merge(local.common_tags, {
    "Name" = var.name
    "Environment" = var.environment
  })
}

module "webapp" {
  source = "./modules/ec2"
  name = "Website"
  environment = "Development"
  # client = "Eclectic"
  # provider = "Allunel"

  # tags = merge(local.common_tags, {
  #   "Name" = "${var.name}"
  #   "Environment" = var.environment
  # })
  tags = {
    "Name" = var.name
    "Environment" = var.environment
  }
}
