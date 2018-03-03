provider "aws" {		
	version						= "1.9"
	shared_credentials_file 		= "${var.aws_credentials_file}"
	region     					= "${var.aws_region}"
	profile    					= "${var.aws_credentials_profile}"
}

# Load modules
module "k8Node" {
	source 					= "../../../modules/aws/k8/iam"
}
