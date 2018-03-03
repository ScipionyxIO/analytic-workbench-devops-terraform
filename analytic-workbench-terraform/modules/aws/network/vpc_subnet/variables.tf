variable "vpc_name" {}

variable "vcp_third_oct" {}

variable "environment" {}

variable "aws_availability_zones" {
	type = "list"
	default = [ "a", "b", "c" ]
}


