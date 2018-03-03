#
data "aws_region" "current" { }

data "aws_vpc" "vpc" {
	tags {
    		Name = "${var.vpc_name}"
	}
}

data "aws_route_table" "public" {
	vpc_id  = "${data.aws_vpc.vpc.id}"
	tags {
		Visibility = "Public"
	}
}

data "aws_route_table" "private" {
	vpc_id  = "${data.aws_vpc.vpc.id}"
	tags {
		Visibility = "Private"
	}
}

#	10.0.0.0/19			-> Infrastructure - Private
#		10.0.0.0/21		-> Infrastructure - Private- Az A
#		10.0.8.0/21		-> Infrastructure - Private- Az B
#		10.0.16.0/21		-> Infrastructure - Private- Az C
#		10.0.24.0/21		-> Infrastructure - Private- Az SPARE	
resource "aws_subnet" "vcp_private_az" {
	count = 3
	vpc_id = "${data.aws_vpc.vpc.id}"
	availability_zone = "${data.aws_region.current.name}${var.aws_availability_zones[count.index]}"
	cidr_block = "10.0.${var.vcp_third_oct + 8 * count.index }.0/21"
	tags {
    		Name = "${var.vpc_name} ${var.environment} Private ${var.aws_availability_zones[count.index]}",
    		Environment 			= "${var.environment}",
    		Visibility			= "Private"
    		AvailabilityZone		= "${var.aws_availability_zones[count.index]}"
  	}
  	map_public_ip_on_launch = false
  	assign_ipv6_address_on_creation = false
}

#	10.0.32.0/19			-> Infrastructure - Public
#		10.0.32.0/21		-> Infrastructure - Public- Az A
#		10.0.40.0/21		-> Infrastructure - Public- Az B
#		10.0.48.0/21		-> Infrastructure - Public- Az C
#		10.0.56.0/21		-> Infrastructure - Public- Az SPARE
resource "aws_subnet" "vcp_public_az" {
	count = 3
	vpc_id = "${data.aws_vpc.vpc.id}"
	availability_zone = "${data.aws_region.current.name}${var.aws_availability_zones[count.index]}"
	cidr_block = "10.0.${var.vcp_third_oct + 8*4 + 8 * count.index }.0/21"
	tags {
    		Name = "${var.vpc_name} ${var.environment} Public ${var.aws_availability_zones[count.index]}",
    		Environment 		= "${var.environment}",
    		Visibility		= "Public"
    		AvailabilityZone	= "${var.aws_availability_zones[count.index]}"
  	}
  	map_public_ip_on_launch = true
  	assign_ipv6_address_on_creation = false
}

resource "aws_route_table_association" "public" {
	count = 3
	subnet_id      = "${aws_subnet.vcp_public_az.*.id[count.index]}"
	route_table_id = "${data.aws_route_table.public.id}"
}

resource "aws_route_table_association" "private" {
	count = 3
	subnet_id      = "${aws_subnet.vcp_private_az.*.id[count.index]}"
	route_table_id = "${data.aws_route_table.private.id}"
}
