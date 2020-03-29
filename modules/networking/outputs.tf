# output "subnet" {
#   value = cidrsubnet("10.0.0.0/16", 8, 10+7) # 10.24.0.0/15
# }
#
# output "dynamic_subnet" {
#   value = format("10.0.%d.0/8", var.az)
# }
#
# output "list_of_subnets-private" {
#   value = aws_subnet.website_private.*.id
# }
