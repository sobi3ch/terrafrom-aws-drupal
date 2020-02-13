# variable "s3_bucket_name" {
#   default = [
#     "prod-gatsby"
#   ]
# }
#
# resource "aws_s3_bucket" "allunel-page" {
#   count         = length(var.s3_bucket_name)
#   bucket        = "allunel-${element(var.s3_bucket_name, count.index)}"
#   acl    = "private"
#
#   tags = {
#     Name        = "Allunel ${element(var.s3_bucket_name, count.index)} bucket"
#     Environment = element(var.s3_bucket_name, count.index)
#   }
# }
