terraform {
	backend "s3" {
    		bucket = "terraform-remote-configuration"
    		key    = "terraform/deployments/infrastructure/rancher"
    		region = "us-east-2"
  	}
}

provider "aws" {		
	version					= "1.9"
	shared_credentials_file 	= "${var.aws_credentials_file}"
	region     				= "${var.aws_region}"
	profile    				= "${var.aws_credentials_profile}"
}

data "aws_db_instance" "infrastructure" {
	db_instance_identifier = "infrastructure"
}

# Load modules
module "rancher" {
	source 		= "../../../modules/aws/rancher"
	environment	= "Infrastructure"
	db_host		= "${data.aws_db_instance.infrastructure.address}"
	db_port		= "${data.aws_db_instance.infrastructure.port}"
	db_user		= "rancher"
	db_pass		= "rancher"
	db_name		= "rancher"
}


