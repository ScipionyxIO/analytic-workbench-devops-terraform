resource "aws_s3_bucket" "terraform" {
	bucket = "terraform-remote-configuration"
	acl    = "private"
	tags {
    		Name        = "Terraform Remote Configuration"
    		Environment = "Infrastructure"
  	}
  	versioning {
    		enabled = true
  	}
}
