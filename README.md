
# Terraform Drupal architecture

This project aim to reproduce Drupal architecture based on this https://aws.amazon.com/efs/resources/aws-refarch-drupal/
document.

It should include AWS as cloud provider, Terrafrom for IaaC and finally  Packer
for VM golden image automation based on Amazon Linux 2.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.43 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.43.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_networking"></a> [networking](#module\_networking) | ./modules/networking | n/a |
| <a name="module_webapp"></a> [webapp](#module\_webapp) | ./modules/ec2 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.drupal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_template.foo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_lb.drupal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.drupal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.drupal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_ami.drupal_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client"></a> [client](#input\_client) | Client we are working for | `string` | `"Eclectic"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Enviroment (dev/stage/prod/etc) | `string` | `"Development"` | no |
| <a name="input_name"></a> [name](#input\_name) | Project name | `string` | `"Website"` | no |
| <a name="input_supplier"></a> [supplier](#input\_supplier) | Copany which make acctual work | `string` | `"Allunel"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_endpoint"></a> [alb\_endpoint](#output\_alb\_endpoint) | Application Load Balancer endpoint URL |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
