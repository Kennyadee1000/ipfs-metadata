data "aws_route53_zone" "zone" {
  count = var.enable_https ? 1 : 0
  name  = var.domain_name
}