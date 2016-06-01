# Records for bf-staging.com
resource "aws_route53_zone" "bf-vu" {
   name = "bf.vu"
}

# Alias Bf.vu to the ELB
resource "aws_route53_record" "a-bf-vu" {
   zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
   name = "bf.vu"
   type = "A"

   alias {
     name = "${aws_elb.brandfolder-all.dns_name}"
     zone_id = "${aws_elb.brandfolder-all.zone_id}"
     evaluate_target_health = true
    }
}

resource "aws_route53_record" "71CDE341CEF6A8E1C863429950BB2017-bf-vu" {
  zone_id = "${aws_route53_zone.bf-vu.zone_id}"
  name = "71cde341cef6a8e1c863429950bb2017.bf.vu"
  ttl = 3600
  type = "CNAME"
  records = ["20070E0D8C90D535D3E6D93EA0F46FD007013E8F.comodoca.com"]
}

resource "aws_route53_record" "agency-bf-vu" {
  zone_id = "${aws_route53_zone.bf-vu.zone_id}"
  name = "agency.bf.vu"
  ttl = 3600
  type = "CNAME"
  records = ["www.netlify.com"]
}

resource "aws_route53_record" "example-bf-vu" {
  zone_id = "${aws_route53_zone.bf-vu.zone_id}"
  name = "example.bf.vu"
  ttl = 3600
  type = "CNAME"
  records = ["www.netlify.com"]
}

resource "aws_route53_record" "share-bf-vu" {
  zone_id = "${aws_route53_zone.bf-vu.zone_id}"
  name = "share.bf.vu"
  ttl = 3600
  type = "CNAME"
  records = ["cname.bitly.com"]
}