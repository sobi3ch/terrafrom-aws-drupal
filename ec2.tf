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

# EC2
# resource "aws_instance" "web" {
#   # ami           = data.aws_ami.ubuntu.id
#   ami           = "ami-083b53142137770ad"
#   instance_type = "t3.micro"
#   subnet_id = aws_subnet.website-public[0].id
#   vpc_security_group_ids = [
#     aws_security_group.webserver.id
#   ]
#   tags = {
#     Name = var.name
#     Client = var.client
#     Env = var.env
#     Provider = var.solution_provider
#   }
# }
