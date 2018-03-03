
data "aws_caller_identity" "current" {}

resource "aws_elasticsearch_domain" "elastic" {
	domain_name           = "${var.domain_name}"
	elasticsearch_version = "${var.elasticsearch_version}"
  	cluster_config {
    		instance_type = "t2.micro.elasticsearch"
  	}
  	advanced_options {
    		"rest.action.multi.allow_explicit_index" = "true"
  	}
  	access_policies = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": 		"Allow",
      "Principal": 	{ "AWS": ["*"] },
      "Action": 		[ "es:*" ],
      "Resource": 	"arn:aws:es:${var.aws_region}:${data.aws_caller_identity.current.account_id}:domain/${var.domain_name}/*"
    }
  ]
}
CONFIG
	ebs_options {
		ebs_enabled 	= true
		volume_type	= "standard"
		volume_size	= 10 
	}
	snapshot_options {
    		automated_snapshot_start_hour = 23
  	}
  	tags {
    		#Domain = "TestDomain"
    		Environment = "${var.environment}"
  	}
}

data "aws_route53_zone" "primary" {
	name = "scipionyx.org"
}

resource "aws_route53_record" "dns" {
	zone_id = "${data.aws_route53_zone.primary.zone_id}"
	name    = "es_${var.domain_name}"
	type    = "CNAME"
	ttl     = "300"
  	records = [ "${aws_elasticsearch_domain.elastic.endpoint}" ]
}