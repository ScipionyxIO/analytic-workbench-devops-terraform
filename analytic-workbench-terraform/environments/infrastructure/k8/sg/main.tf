terraform {
	backend "s3" {
    		bucket = "terraform-remote-configuration"
    		key    = "terraform/deployments/infrastructure/k8/sg"
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
module "k8Node" {
	source 					= "../../../../modules/aws/k8/sg"
}
