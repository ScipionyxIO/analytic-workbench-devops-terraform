#
variable "var.terraform_bucket" 		{ default = "terraform-remote-configuration" }
variable "aws_region" 				{ default = "us-east-2" }
variable "aws_credentials_profile" 	{ default = "terraform" }
variable "aws_credentials_file" 		{ default = "/Users/rmendes/.aws/credentials" }