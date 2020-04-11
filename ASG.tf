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

resource "aws_launch_configuration" "as_conf" {
  image_id      = data.aws_ami.Drupal_AMI.id
  instance_type = "t3.micro"
  spot_price    = "0.0108"
  key_name      = "aws.stockholm.xps13"

  user_data = file("./user_data.txt")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bar" {
  name                 = "terraform-asg-drupal"
  launch_configuration = aws_launch_configuration.as_conf.name
  availability_zones   = module.networking.AZs
  min_size             = 1
  max_size             = 2
}
