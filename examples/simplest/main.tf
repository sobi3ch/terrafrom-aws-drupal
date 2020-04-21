# module "drupal" {
#   source "../.."
#
#   options_webapp = {
#     asg_min_size             = 1
#     asg_desired_capacity     = 1
#     asg_max_size             = 4
#   }
#
#
#   create_alb        = true
#   options_alb = {
#     target_group = "bleble"
#   }
#   create_rds        = false
#   create_bastion    = false
#   create_s3         = false
#   create_efs        = false
#   create_ses        = false
#   create_cloudfront = false
# }




################################################################################
# Idea is to build any webapp from existing common modules
################################################################################
# use https://github.com/pnikosis/semtag


## networking <---------------------
# VPC, public/private subnets, routing tables,
# ACL, security groups
# Internet Gateways
# Route53(?); record set/
#
# defaults:
# * creating record set is an options

## webapp <---------------------
# drupal ec2 instances in Target groups + ASG
# ALB + listener and optionally certificate for HTTPS
# and redirections HTTP -> HTTPS
#
# defautls:
# *
# * create in private subnets
#   (even if bastion will not be created then owner of the app needs to make a
#   direct dectionion to put instances in public subnet)
#   If in private subnets then create single NAT gateway (default) or one per
#   AZ.
# * ASG size 2:6 + ALB + listeners (HTTP->HTTPS + HTTPS with cert)
# * web instances in private subnets
# mandatory
# * region
# * name of application
# * image name
module "lb" {}
module "webapp" {}

## database <---------------------
# use https://github.com/terraform-aws-modules/terraform-aws-rds
# Placed DB(s) in seperate private subnets!
# https://blog.stratus10.com/aws-best-practices-3-tier-infrastructure
#
# Details in parameter store
#
# defaults:
# * RDS create: true
# * single instance; 5GB; always in private subnets
# * memcached: false
module "rds" {}
module "memcached" {}

## bastion <---------------------
# In public subnets as ASG with multi AZ settings
# and min1:max1 size + elastic IP
#
# defaults:
# * create: true
module "bastion" {}

## acceleration <---------------------
# Information in parameter store
#
# defaults:
# * CF create: false
# * S3 create: true
module "cloudfront" {}
moudle "s3" {}

## EFS <---------------------
# Endpoints + information in parameter store
#
# defaults:
# * create: true
module "efs" {}

## email <---------------------
# Information in parameter store
#
# defaults:
# * create: false
# mandatory
# * existing domain
module "ses" {}


#### FUTURE
## monitoring <---------------------
# cloudwatch first
# elastic stack second

## integration (CI) <---------------------

## deployment (CD) <---------------------
# codedeploy first

## backups <---------------------
# first https://aws.amazon.com/backup/

## analitics <---------------------

## queues <---------------------

## notify <---------------------
# slack first https://github.com/terraform-aws-modules/terraform-aws-notify-slack
