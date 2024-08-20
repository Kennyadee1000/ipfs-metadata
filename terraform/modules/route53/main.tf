resource "aws_route53_record" "record" {
  count   = var.enable_https ? 1 : 0
  name    = "${var.app_name}-${var.environment}.${var.domain_name}"
  type    = "A"
  zone_id = data.aws_route53_zone.zone[0].zone_id

  alias {
    evaluate_target_health = true
    name                   = var.load_balance_dns_name
    zone_id                = var.load_balance_zone_id
  }
}