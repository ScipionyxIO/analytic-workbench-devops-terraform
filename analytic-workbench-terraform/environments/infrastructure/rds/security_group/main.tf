terraform {
	backend "s3" {
    		bucket = "terraform-remote-configuration"
    		key    = "terraform/deployments/infrastructure/rds/security_group"
    		region = "us-east-2"
  	}
}

provider "aws" {		
	version						= "1.9"
	shared_credentials_file 		= "${var.aws_credentials_file}"
	region     					= "${var.aws_region}"
	profile    					= "${var.aws_credentials_profile}"	
}

module "rds-security-group" {
	source 					= "../../../../modules/aws/rds/security_group"
	vpc_name					= "Scipionyx Vpc"
	environment				= "Infrastructure"
	visibility				= "private"
}
