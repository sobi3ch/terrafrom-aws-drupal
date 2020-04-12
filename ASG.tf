data "aws_ami" "Drupal_AMI" {
  most_recent = true
  owners = ["self"]

  filter {
    name   = "name"
    values = ["Terraform Drupal*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

resource "aws_autoscaling_group" "bar" {
  name                 = "terraform-asg-drupal"
  launch_template {
    id      = aws_launch_template.foo.id
    version = "$Latest"
  }
  availability_zones   = module.networking.AZs
  min_size             = 1
  max_size             = 2
}

resource "aws_launch_template" "foo" {
  name = "drupal"
  image_id = data.aws_ami.Drupal_AMI.id
  instance_type = "t3.micro"
  key_name = "aws.stockholm.xps13"

  # todo: add security groups output in networking module and then you can use it here; then t apply and check
  # security_group_names = [ module.networking.webserver_sg.name , module.networking.ssh_sg.name ]
  instance_initiated_shutdown_behavior = "terminate"

  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = "0.0108"
    }
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Drupal from Launch template"
    }
  }

  user_data = filebase64("./user_data.sh")
}
