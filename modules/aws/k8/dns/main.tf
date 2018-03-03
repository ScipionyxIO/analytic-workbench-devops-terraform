##
## This module adds all K8 instances nodes to a loadbalanced DNS 
##

data "aws_vpc" "vpc" {
	tags {
    		Name = "${var.vpc_name}" 
	}
}

## List of all nodes, selected by type and environment
data "aws_instances" "nodes" {
	instance_tags {
    		Type 		= "${var.k8_node_type}",
    		Environment 	= "${var.environment}"
  	}
}

data "aws_route53_zone" "primary" {
	name = "${var.dns_zone}"
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
