# data "aws_ami" "ubuntu" {
#   most_recent = true
#
#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
#   }
#
#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
#
#   owners = ["099720109477"] # Canonical
# }

# # EC2
# resource "aws_instance" "web" {
#   # ami           = data.aws_ami.ubuntu.id
#   ami           = "ami-0e850e0e9c20d9deb"
#   instance_type = "t3.micro"
#
#   tags = {
#     Name = "Web"
#     Creator = "Terraform"
#     Env = "Stage"
#   }
# }
