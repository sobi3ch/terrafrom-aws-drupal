# output "vpc" {
#   value = module.networking.vpc.id
# }
#
# output "subnets_public" {
#   value = module.networking.subnets_public
# }
#
# output "subnets_private" {
#   value = module.networking.subnets_private
# }
#
# output "AZs" {
#   value = module.networking.AZs
# }
#
# output "key_name_test" {
#   value = module.ec2.key_name_test
# }
#
# output "webserver_sg" {
#   value = {
#     name = module.networking.webserver_sg.name
#     id   = module.networking.webserver_sg.id
#   }
# }
#
# output "ssh_sg" {
#   value = {
#     name = module.networking.ssh_sg.name
#     id   = module.networking.ssh_sg.id
#   }
# }

output "alb_endpoint" {
  value = aws_lb.drupal.dns_name
}
