terraform {
	backend "s3" {
    		bucket = "terraform-remote-configuration"
    		key    = "terraform/deployments/infrastructure/k8/nodes/infra"
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
	quantity			= 2
	source 			= "../../../../../modules/aws/k8/node"
	az_indicator		= "b"
	pem				= "../../../Infrastructure.pem"
	environment		= "Infrastructure"
	agent			= "sudo docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:v1.2.9 http://rancher.scipionyx.org/v1/scripts/7090E310DD68ABA69A16:1514678400000:o9KZrcxnQUUT1OnCIr9ArE7NhiA"
}
