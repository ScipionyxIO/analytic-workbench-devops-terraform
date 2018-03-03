# Configure the AWS Provider

data "aws_vpc" "vpc" {
	tags { Name = "${var.vpc_name}" }
}

data "aws_subnet" "private_a" {
	tags {
    		Environment 			= "${var.environment}"
    		Visibility			= "Private"
    		AvailabilityZone		= "a"
  	}
}

data "aws_subnet" "private_b" {
	tags {
    		Environment 			= "${var.environment}"
    		Visibility			= "Private"
    		AvailabilityZone		= "b"
  	}
}

data "aws_subnet" "private_c" {
	tags {
    		Environment 			= "${var.environment}"
    		Visibility			= "Private"
    		AvailabilityZone		= "c"
  	}
}

data "aws_subnet" "public_a" {
	tags {
    		Environment 			= "${var.environment}"
    		Visibility			= "Public"
    		AvailabilityZone		= "a"
  	}
}

data "aws_subnet" "public_b" {
	tags {
    		Environment 			= "${var.environment}"
    		Visibility			= "Public"
    		AvailabilityZone		= "b"
  	}
}

data "aws_subnet" "public_c" {
	tags {
    		Environment 			= "${var.environment}"
    		Visibility			= "Public"
    		AvailabilityZone		= "c"
  	}
}

resource "aws_security_group" "main" {
	name        		= "rds_mariadb_${var.environment}_${var.visibility}"
	description 		= "Allow all ${var.visibility} inbound to MariaDB"
  	vpc_id      		= "${data.aws_vpc.vpc.id}"
  	ingress {
    		from_port   = 3306
    		to_port     = 3306
    		protocol    = "tcp"
    		cidr_blocks = [
    			"${data.aws_subnet.private_a.cidr_block}",
    			"${data.aws_subnet.private_b.cidr_block}",
    			"${data.aws_subnet.private_c.cidr_block}",
    			"${data.aws_subnet.public_a.cidr_block}",
    			"${data.aws_subnet.public_b.cidr_block}",
    			"${data.aws_subnet.public_c.cidr_block}"
		]
  	}
  	egress {
    		from_port	= 0
    		to_port		= 0
    		protocol		= "tcp"
    		cidr_blocks	= [
    			"${data.aws_subnet.private_a.cidr_block}",
    			"${data.aws_subnet.private_b.cidr_block}",
    			"${data.aws_subnet.private_c.cidr_block}",
    			"${data.aws_subnet.public_a.cidr_block}",
    			"${data.aws_subnet.public_b.cidr_block}",
    			"${data.aws_subnet.public_c.cidr_block}"
		]
  	}
  	tags {
    		Name			= "RDS Mariadb ${var.environment} ${var.visibility}"
    		Environment 	= "${var.environment}"
    		Visibility	= "Private"
    		Type			= "RDS"
  	}
}