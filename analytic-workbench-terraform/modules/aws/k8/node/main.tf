#
data "aws_ami" "ubuntu" {
	most_recent = true
	filter {
    		name   = "name"
    		values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  	}
  	filter {
    		name   = "virtualization-type"
    		values = ["hvm"]
  	}
  	owners = ["099720109477"] # Canonical
}

data "aws_vpc" "vpc" {
	tags {
    		Name = "Scipionyx Vpc" 
	}
}

data "aws_subnet" "public_node" {
	availability_zone 	= "us-east-2${var.az_indicator}"
	tags {
    		Environment 		= "${var.environment}",
    		Visibility		= "Public" 
	}
}

data "aws_security_group" "node" {
    name = "infrastructure_sg_k8_node"
}

resource "aws_instance" "node" {
	count						= "${var.quantity}"
	ami          				= "${data.aws_ami.ubuntu.id}"
	#instance_type 				= "t2.micro"
	instance_type 				= "t2.small"
	#instance_type 				= "t2.medium"
	iam_instance_profile 		= "ScipionyxK8NodeInstanceProfile"
	key_name						= "${var.environment}"
	vpc_security_group_ids 		= [ 
		"${data.aws_security_group.node.id}" 
	]
	subnet_id 					= "${data.aws_subnet.public_node.id}" 
    associate_public_ip_address 	= true
  	provisioner "remote-exec" {
  		inline = [
    			"curl https://releases.rancher.com/install-docker/17.03.sh | sh",
    			"${var.agent}"
    		]
  		connection {
  			user			= "ubuntu"
       		private_key = "${file(var.pem)}"
    		}
    }
    tags { 
   		Name = "${var.environment}-K8-Node-${count.index}"
   		Environment = "${var.environment}" 
   		Type = "K8 Node"
   		K8NodeNumber = "${count.index}" 
   	}
}
