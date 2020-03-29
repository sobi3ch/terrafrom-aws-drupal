module "networking" {
  source = "./modules/networking"

  tags = merge(local.common_tags, {
    "Name" = "${var.name}"
    "Environment" = var.env
  })
}
