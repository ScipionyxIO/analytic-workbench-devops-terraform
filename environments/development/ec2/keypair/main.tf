terraform {
	backend "s3" {
    		bucket = "terraform-remote-configuration"
    		key    = "terraform/environments/development/ec2/keypair"
    		region = "us-east-2"
  	}
}

provider "aws" {		
	version						= "1.9"
	shared_credentials_file 		= "${var.aws_credentials_file}"
	region     					= "${var.aws_region}"
	profile    					= "${var.aws_credentials_profile}"	
}

module "keypair_development" {
	source 		= "../../../../modules/aws/ec2/keypair"
	key_pair		= "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCWUJKkX+EkV+mVvi11DrJcXfGLGGT9LUIdEeDkgCGuM3fbqCILgfvU0bM43Ege5zy7pNAD45PAThF8zz+AuhWZpF8/s0Dm2HqiZA5okuu62BHbFQ3dJGieyar+tZl4mO9zJ78+sIsEOhaZGvUSa+uql8/IpwBzz3L+4RgxhL+N5Szl1lQeFLyhTVJzWadXyBR2xt945hZcyyNBVW7M8uYW32w4ItxeI2bUkQSnNS8Xb2enm0+EHKAbLxZJOaVn+K5eTuYSpIOOrUUZ89cHS+PBeyTpq7Ig/VkwTP0YdBY5LWTkbiYAPJoKuyk+WRaiVcFUtJjNO+5onvXtq0pHdW1/"
	key_name		= "Development"
}