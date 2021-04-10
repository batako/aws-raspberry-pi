data "aws_route53_zone" "main" {
  name = var.route53_zone_name
}

resource "aws_route53_record" "ec2" {
  zone_id = data.aws_route53_zone.main.id
  name    = var.route53_record_name
  type    = "A"
  ttl     = "300"
  records = module.ec2_cluster.public_ip
}
