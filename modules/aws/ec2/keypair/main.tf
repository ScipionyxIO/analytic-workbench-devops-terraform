resource "aws_key_pair" "infrastructure" {
	key_name   = "${var.key_name}"
	public_key = "${var.key_pair}"
}