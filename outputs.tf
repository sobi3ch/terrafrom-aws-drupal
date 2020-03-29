output "vpc" {
  value = module.networking.vpc.id
}

output "subnets_public" {
  value = module.networking.subnets_public
}

output "subnets_private" {
  value = module.networking.subnets_private
}
