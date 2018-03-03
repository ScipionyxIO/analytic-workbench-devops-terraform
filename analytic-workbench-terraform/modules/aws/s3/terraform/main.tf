data "aws_s3_bucket" "terraform" {
    bucket = "terraform-remote-configuration"
}

resource "aws_s3_bucket_object" "terraform-deployment-k8-nodes-infra" {
    bucket = "${data.aws_s3_bucket.terraform.id}"
    acl    = "private"
    key    = "${var.folder}"
    source = "/dev/null"
}