#
resource "aws_vpc" "scipionyx" {
	cidr_block	= "10.0.0.0/16"
	enable_dns_hostnames = true
	tags {
    		Name = "${var.vpc_name}"
	}
}

resource "aws_internet_gateway" "scipionyx" {
  	vpc_id		= "${aws_vpc.scipionyx.id}"
  	tags {
		Name		= "${var.vpc_name} Internet Gateway"
  	}
}

resource "aws_route_table" "private" {
	vpc_id = "${aws_vpc.scipionyx.id}"
  	tags {
    		Name = "${var.vpc_name} Private"
    		Visibility = "Private"
  	}
}

resource "aws_route_table" "public" {
	vpc_id = "${aws_vpc.scipionyx.id}"
  	route {
    		cidr_block = "0.0.0.0/0"
    		gateway_id = "${aws_internet_gateway.scipionyx.id}"
  	}
  	tags {
    		Name = "${var.vpc_name} Public"
    		Visibility = "Public"
  	}
}