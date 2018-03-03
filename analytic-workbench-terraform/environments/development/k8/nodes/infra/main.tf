terraform {
	backend "s3" {
    		bucket = "terraform-remote-configuration"
    		key    = "terraform/deployments/development/k8/nodes/infra"
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
	az_indicator		= "c"
	pem				= "../../../Development.pem"
	environment		= "Development"
	agent			= "sudo docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:v1.2.9 http://rancher.scipionyx.org/v1/scripts/76A95717BEEEC345A04B:1514678400000:yCDM59nkKEPxwY7azJQEA5lN7w"
}
