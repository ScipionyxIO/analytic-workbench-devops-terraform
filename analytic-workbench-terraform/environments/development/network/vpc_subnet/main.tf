terraform {
	backend "s3" {
    		bucket = "terraform-remote-configuration"
    		key    = "terraform/environments/development/network/vpc_subnet"
    		region = "us-east-2"
  	}
}

provider "aws" {	
	version						= "1.9"	
	shared_credentials_file 		= "${var.aws_credentials_file}"
	region     					= "${var.aws_region}"
	profile    					= "${var.aws_credentials_profile}"	
}

module "vpc_subnet_development" {
	source 			= "../../../../modules/aws/network/vpc_subnet"
	vpc_name			= "Scipionyx Vpc"
	vcp_third_oct	= "192"
	environment		= "Development"
}