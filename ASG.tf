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

resource "aws_launch_template" "foo" {
  name = "drupal"
  image_id = data.aws_ami.Drupal_AMI.id
  instance_type = "t3.micro"
  key_name = "aws.stockholm.xps13"

  # todo: add security groups output in networking module and then you can use it here; then t apply and check
  vpc_security_group_ids = [
    module.networking.webserver_sg.id,
    module.networking.ssh_sg.id
  ]
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

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Drupal from Launch template"
    }
  }

  user_data = filebase64("./user_data.sh")
}


resource "aws_autoscaling_group" "drupal" {
  name                 = "terraform-asg-drupal"
  vpc_zone_identifier  = module.networking.subnets_public
  min_size             = 1
  desired_capacity     = 1
  max_size             = 4
  target_group_arns    = [ aws_lb_target_group.drupal.arn ]

  launch_template {
    id      = aws_launch_template.foo.id
    version = "$Latest"
  }
}
