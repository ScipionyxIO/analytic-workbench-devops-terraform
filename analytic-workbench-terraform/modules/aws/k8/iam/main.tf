#
resource "aws_iam_policy" "ScipionyxK8NodeInstancePolicy" {
	name        = "ScipionyxK8NodeInstancePolicy"
	path        = "/"
	description = "Scipionyx K8 Node Instance Policy"
	policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ec2:*",
            "Resource": "*"
        },
        {
      		"Effect": "Allow",
      		"Action": "ec2:Describe*",
      		"Resource": "*"
    		},
    		{
      		"Effect": "Allow",
      		"Action": "ec2:AttachVolume",
      		"Resource": "*"
    		},
    		{
      		"Effect": "Allow",
      		"Action": "ec2:DetachVolume",
      		"Resource": "*"
    		},
        {
            "Effect": "Allow",
            "Action": "elasticloadbalancing:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "cloudwatch:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "autoscaling:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:CreateServiceLinkedRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:AWSServiceName": [
                        "autoscaling.amazonaws.com",
                        "ec2scheduled.amazonaws.com",
                        "elasticloadbalancing.amazonaws.com",
                        "spot.amazonaws.com",
                        "spotfleet.amazonaws.com"
                    ]
                }
            }
        }
    ]
}
EOF
}

resource "aws_iam_role" "ScipionyxK8NodeInstanceRole" {
	name = "ScipionyxK8NodeInstanceRole"
	assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ScipionyxK8NodeInstanceRoleAttachment" {
	role       = "${aws_iam_role.ScipionyxK8NodeInstanceRole.name}"
    policy_arn = "${aws_iam_policy.ScipionyxK8NodeInstancePolicy.arn}"
}

resource "aws_iam_instance_profile" "ScipionyxK8NodeInstanceProfile" {
	name = "ScipionyxK8NodeInstanceProfile"
	roles = ["${aws_iam_role.ScipionyxK8NodeInstanceRole.name}"]		
}