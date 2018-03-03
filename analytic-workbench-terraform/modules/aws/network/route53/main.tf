#
resource "aws_route53_zone" "environment" {
	name 	= "${var.environment_short}.scipionyx.org"
	comment 	= "Scipionyx ${var.environment}"
	tags {
    		Environment = "${var.environment}"
  	}
  	 
}