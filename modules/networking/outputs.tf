output "subnets_public" {
  description = "Public subents"
  value = aws_subnet.website_public.*.id
}

output "subnets_private" {
  description = "Private subents"
  value = aws_subnet.website_private.*.id
}

output "vpc" {
  value = {
    "id"                        = aws_vpc.main.id
    "arn"                       = aws_vpc.main.arn
    "cidr_block"                = aws_vpc.main.cidr_block
    "instance_tenancy"          = aws_vpc.main.instance_tenancy
    "enable_dns_support"        = aws_vpc.main.enable_dns_support
    "enable_dns_hostnames"      = aws_vpc.main.enable_dns_hostnames
    "default_security_group_id" = aws_vpc.main.default_security_group_id
    "default_route_table_id"    = aws_vpc.main.default_route_table_id
  }
}

output "AZs" {
  value = data.aws_availability_zones.available.names
}
