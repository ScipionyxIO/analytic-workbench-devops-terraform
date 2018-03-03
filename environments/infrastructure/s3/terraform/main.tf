# Load modules

provider "aws" {		
	version						= "1.9"
	shared_credentials_file 		= "${var.aws_credentials_file}"
	region     					= "${var.aws_region}"
	profile    					= "${var.aws_credentials_profile}"	
}

module "terraform-bucket" {
	source	= "../../../../modules/aws/s3/bucket"
	folder	= "terraform/deployments/infrastructure/"
}

module "terraform-folder" {
	source	= "../../../../modules/aws/s3/terraform"
	folder	= "terraform/deployments/infrastructure/"
}
