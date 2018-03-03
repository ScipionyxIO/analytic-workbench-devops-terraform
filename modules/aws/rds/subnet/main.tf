# Configure the AWS Provider

data "aws_vpc" "vpc" {
	tags { Name = "${var.vpc_name}" }
}

data "aws_subnet_ids" "private" {
	vpc_id = "${data.aws_vpc.vpc.id}"
	tags {
    		Visibility	= "Private"
    		Environment = "${var.environment}",
  	}
}

data "aws_subnet_ids" "public" {
	vpc_id = "${data.aws_vpc.vpc.id}"
	tags {
    		Visibility	= "Public"
    		Environment = "${var.environment}",
  	}
}

resource "aws_db_subnet_group" "private" {
	name       	= "${lower(var.environment)}_private"
	description 	= "${var.environment} Private"
	subnet_ids 	= ["${data.aws_subnet_ids.private.ids}"]
	tags {
    		Name 		= "${var.environment} Private"
    		Visibility	= "Private"
    		Environment 	= "${var.environment}",
	}
}

resource "aws_db_subnet_group" "public" {
	name       	= "${lower(var.environment)}_public"
	description = "${var.environment} Public"
	subnet_ids 	= ["${data.aws_subnet_ids.public.ids}"]
	tags {
    		Name 		= "${var.environment} Public"
    		Visibility	= "Public"
    		Environment 	= "${var.environment}",
	}
}