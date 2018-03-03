terraform {
	backend "s3" {
    		bucket = "${var.terraform_bucket}"
    		key    = "terraform/deployments/network/vpc"
    		region = "${var.aws_region}"
  	}
}

provider "aws" {		
	version						= "1.9"
	shared_credentials_file 		= "${var.aws_credentials_file}"
	region     					= "${var.aws_region}"
	profile    					= "${var.aws_credentials_profile}"	
}

module "keypair-infrastructure" {
	source 		= "../../../modules/aws/ec2/keypair"
	key_pair		= "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCZisjzRWInOe3BwQHDBBuA/aBe1JQCCdppDMFHT6cbH9uRoTok6lqCDrfF+WwJnS9bADqgRXRxf7kqnvTpqqyked+p7+SLtLrUPHBJrR4lsURWvKYLv4zQBZDNCdIGHkn0sBpqNaR0llbjCvBWHTE1vSVhAEH0O1n83prz7d1eomKXgHc3r0AaKbU4v3tSmeDpY6LTDdqA9e9gSG/KU6JiRPE+GBoK/xMbkIGcJbq9YgHT2f4fb1xopYM+jsPDjCfmc0MBXyFupukoz4DkukocZiBcJEJbGBJ4qt7cIiytnvobZjjmSuZ3G6lATpI97i4mQbuJbVetYWplzs69Dr4l"
	key_name		= "Infrastructure"
}

module "keypair-production" {
	source 		= "../../../modules/aws/ec2/keypair"
	key_pair		= "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzW7+jxYHqfCpEjj+B3laaircN6ymAjmZFlH0euAStALbKFoYhfbERkjd2ioHfpk+ADSu5ZeFpMbA1S9TSSne0NkoU9KcQPR58FcJWdIenEUOXXh8YLStYliWspaYMgTfYbLsoKQcqfZysEcRGdKiiRlu0ipCrlk2NeqDGIQHG0aUtJA752niqH0Ul4hCpgNxACXgrPPbdJcFzgmZv0SvavFGKczICIKwaDX5SQXRKOAO4NlfyRkl6eCf8D6BvzCiQBap6rcPBn3vbHMVowpiQf9z+NIGPx56rBSZpZf2cHwcfKBKY4DBmFcMENq6IHK55VyhrmlxeJevk1HugVT1t"
	key_name		= "Production"
}
