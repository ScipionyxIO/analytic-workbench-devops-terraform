terraform {
	backend "s3" {
    		bucket = "terraform-remote-configuration"
    		key    = "terraform/deployments/infrastructure/k8/dns"
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
	environment 	= "Infrastructure"
	dns_name 	= "nexus" 
}

# Load modules
module "config" {
	source 		= "../../../../modules/aws/k8/dns"
	environment 	= "Infrastructure"
	dns_name 	= "config" 
}
