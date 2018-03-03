terraform {
	backend "s3" {
    		bucket = "terraform-remote-configuration"
    		key    = "terraform/environments/development/rds/subnet"
    		region = "us-east-2"
  	}
}

provider "aws" {	
	shared_credentials_file 		= "${var.aws_credentials_file}"
	region     					= "${var.aws_region}"
	profile    					= "${var.aws_credentials_profile}"	
}

module "subnet" {
	source 					= "../../../modules/aws/rds/subnet"
	vpc_name					= "${var.vpc_name}"
	environment				= "Development"
}
