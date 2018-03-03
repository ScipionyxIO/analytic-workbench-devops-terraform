terraform {
	backend "s3" {
    		bucket = "terraform-remote-configuration"
    		key    = "terraform/deployments/infrastructure/network/vpc"
    		region = "us-east-2"
  	}
}

provider "aws" {	
	version						= "1.9"	
	shared_credentials_file 		= "${var.aws_credentials_file}"
	region     					= "${var.aws_region}"
	profile    					= "${var.aws_credentials_profile}"	
}

module "infra-vpc-default" {
	source 					= "../../../../modules/aws/network/vpc_default"
}

module "vpc" {
	source 					= "../../../../modules/aws/network/vpc"
	vpc_name					= "Scipionyx Vpc"
}