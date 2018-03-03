#
variable "aws_region" 				{ 	default = "us-east-2" }	
variable "aws_credentials_profile" 	{ 	default = "scipionyx" }
variable "aws_credentials_file" 		{ 	default = "~/.aws/credentials" }

variable "vpc_name" {
	default = "Scipionyx Vpc"
}