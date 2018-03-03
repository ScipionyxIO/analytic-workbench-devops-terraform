#

data "aws_instances" "nodes" {
	instance_tags {
    		Type 		= "K8 Node",
    		Environment 	= "${var.environment}"
  	}
}

data "aws_vpc" "vpc" {
	tags {
    		Name = "Scipionyx Vpc" 
	}
}

data "aws_route53_zone" "primary" {
	name = "scipionyx.org"
}

resource "aws_route53_record" "dns" {

	count = "${length(data.aws_instances.nodes.public_ips)}"

	zone_id = "${data.aws_route53_zone.primary.zone_id}"
	name    = "${var.dns_name}"
	type    = "A"
	ttl     = "300"
	
	weighted_routing_policy {
    		weight = 10
  	}
	
	set_identifier = "Node-${count.index}"
	
  	records = [
  		"${data.aws_instances.nodes.public_ips[count.index]}"
	]
	
}
