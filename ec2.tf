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

# Generate SSH key pair
resource "tls_private_key" "generated_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# EC2 key pair
resource "aws_key_pair" "web" {
  key_name   = "ssh-${var.name}-${local.client}"
  public_key = tls_private_key.generated_key.public_key_openssh
  tags = merge(local.common_tags, {
    "Name" = var.name
    "Environment" = var.env
  })
}

# EC2
resource "aws_instance" "web" {
  # ami           = data.aws_ami.ubuntu.id
  ami           = "ami-083b53142137770ad"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.website-public[0].id
  key_name  = aws_key_pair.web.key_name
  vpc_security_group_ids = [
    aws_security_group.webserver.id,
    aws_security_group.ssh.id
  ]

  tags = merge(local.common_tags, {
    "Name" = var.name
    "Environment" = var.env
  })
}

resource "local_file" "ssh_private_key" {
  sensitive_content = tls_private_key.generated_key.private_key_pem
  filename = "ssh-${var.name}-${local.client}.pem"
  file_permission = "0600"
  depends_on = [ tls_private_key.generated_key ]
}
