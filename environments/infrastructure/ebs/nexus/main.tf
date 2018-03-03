terraform {
	backend "s3" {
    		bucket = "terraform-remote-configuration"
    		key    = "terraform/deployments/infrastructure/k8/ebs/nexus"
    		region = "us-east-2"
  	}
}

provider "aws" {		
	version						= "1.9"
	shared_credentials_file 		= "${var.aws_credentials_file}"
	region     					= "${var.aws_region}"
	profile    					= "${var.aws_credentials_profile}"	
}

resource "aws_ebs_volume" "example" {
    availability_zone = "us-east-2b"
    size = 10
    tags {
        Name = "Nexus"
    }
}