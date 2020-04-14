resource "aws_lb_target_group" "drupal" {
  name     = "drupal-terraform-tg"
  vpc_id   = module.networking.vpc.id
  protocol = "HTTP"
  port     = 80
}

resource "aws_lb" "drupal" {
  name               = "drupal-terrafrom-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [ module.networking.webserver_sg.id ]
  subnets            = module.networking.subnets_public

  # enable_deletion_protection = true

  tags = {
    Environment = "test"
  }
}

resource "aws_lb_listener" "drupal" {
  load_balancer_arn = aws_lb.drupal.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.drupal.arn
  }
}
