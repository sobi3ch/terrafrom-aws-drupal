variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = merge(local.common_tags, {
    "Name" = var.name
    "Environment" = var.env
  })
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    "Name" = var.name,
    "Environment" = var.env
  })
}

resource "aws_default_route_table" "main" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(local.common_tags, {
    "Name" = "${var.name}-public"
    "Environment" = var.env
  })
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  # route {
  #     cidr_block = "0.0.0.0/0"
  #     gateway_id = aws_internet_gateway.main.id
  # }

  tags = merge(local.common_tags, {
    "Name" = "${var.name}-private"
    "Environment" = var.env
  })
}

# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "website-public" {
  count = length(data.aws_availability_zones.available.names)
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index+1)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    "Name" = "${var.name}-public"
    "Environment" = var.env
  })

  depends_on = [ data.aws_availability_zones.available ]
}

resource "aws_subnet" "website-private" {
  count = length(data.aws_availability_zones.available.names)
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index+10)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(local.common_tags, {
    "Name" = "${var.name}-private"
    "Environment" = var.env
  })

  depends_on = [ data.aws_availability_zones.available ]
}

resource "aws_route_table_association" "private-association" {
  count = length(data.aws_availability_zones.available.names)
  subnet_id      = aws_subnet.website-private[count.index].id
  route_table_id = aws_route_table.private.id

  depends_on = [ data.aws_availability_zones.available ]
}

resource "aws_security_group" "webserver" {
  name        = "Webserver"
  description = "Allow necessary webserver traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    # prefix_list_ids = ["pl-12c4e678"]
  }

  tags = merge(local.common_tags, {
    "Name" = "${var.name} webserver"
    "Environment" = var.env
  })
}

resource "aws_security_group" "ssh" {
  name        = "SSH"
  description = "Allow SSH from my IP"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["83.4.208.162/32"]
    # prefix_list_ids = ["pl-12c4e678"]
  }

  tags = merge(local.common_tags, {
    "Name" = "${var.name} SSH"
    "Environment" = var.env
  })
}


# output "cidr" {
#   value = "10.0.0.0/8"
# }

# output "subnet" {
#   value = cidrsubnet("10.0.0.0/16", 8, 10+7) # 10.24.0.0/15
# }

# variable "az" {
#   default = 3
# }
#
# output "dynamic_subnet" {
#   value = format("10.0.%d.0/8", var.az)
# }
#
# output "list_of_subnets-private" {
#   value = aws_subnet.website-private.*.id
# }
