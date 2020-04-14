resource "aws_lb_target_group" "drupal" {
  name     = "drupal-terraform-tg"
  vpc_id   = module.networking.vpc.id
  protocol = "HTTP"
  port     = 80
}
