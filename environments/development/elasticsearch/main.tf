terraform {
	backend "s3" {
    		bucket = "terraform-remote-configuration"
    		key    = "terraform/environments/development/elasticsearch"
    		region = "us-east-2"
  	}
}

provider "aws" {
	version						= "1.9"	
	shared_credentials_file 		= "${var.aws_credentials_file}"
	region     					= "${var.aws_region}"
	profile    					= "${var.aws_credentials_profile}"	
}

module "elasticsearch" {
	source 					= "../../../modules/aws/elasticsearch"
	environment				= "Development"
	domain_name				= "development"
	aws_region				= "${var.aws_region}"
}