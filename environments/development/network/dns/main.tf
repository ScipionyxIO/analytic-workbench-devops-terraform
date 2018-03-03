terraform {
	backend "s3" {
    		bucket = "terraform-remote-configuration"
    		key    = "terraform/environments/development/network/dns"
    		region = "us-east-2"
  	}
}

provider "aws" {
	version						= "1.9"	
	shared_credentials_file 		= "${var.aws_credentials_file}"
	region     					= "${var.aws_region}"
	profile    					= "${var.aws_credentials_profile}"	
}

module "vpc" {
	source 					= "../../../../modules/aws/network/route53"
	environment				= "Development"
	environment_short		= "dev"
}