terraform {
	backend "s3" {
    		bucket = "terraform-remote-configuration"
    		key    = "terraform/environments/development/k8/dns"
    		region = "us-east-2"
  	}
}

provider "aws" {		
	version						= "1.9"
	shared_credentials_file 		= "${var.aws_credentials_file}"
	region     					= "${var.aws_region}"
	profile    					= "${var.aws_credentials_profile}"
}

# Load modules
module "dns" {
	source 		= "../../../../modules/aws/k8/dns"
	environment 	= "Development"
	dns_name 	= "elasticsearch"
	dns_zone		= "dev.scipionyx.org"
}