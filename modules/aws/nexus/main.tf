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

#
data "aws_vpc" "vpc" {
	tags {
    		Name = "${var.vpc_name}"
	}
}

#
data "aws_subnet_ids" "private" {
	vpc_id = "${var.vpc_id}"
}

#
data "aws_subnet" "selected" {
	id = "${data.aws_subnet_ids.private.ids[0]}"
}

#
resource "aws_security_group" "infrastructure_nexus_http" {
    name = "infrastructure_sg_nexus_http"
    description = "Infrastructure Nexus"
    ingress {
        from_port   = "80"
        to_port     = "80"
        protocol    = "tcp"
        cidr_blocks = [ "${data.aws_subnet.selected.cidr_block}" ]
    }
    ingress {
        from_port   = "22"
        to_port     = "22"
        protocol    = "tcp"
        cidr_blocks = ["${data.aws_subnet.selected.cidr_block}"]
    }
    tags {
        Name = "Infrastructure Nexus"
    }
    vpc_id = "${var.vpc_id}"
}

#
resource "aws_instance" "infrastructure_nexus" {
	ami          	= "${data.aws_ami.ubuntu.id}"
	instance_type 	= "t2.micro"
	key_name			= "Infrastructure"
   	tags {
    		Name = "Infrastructure-Nexus"
  	}
  	subnet_id     = "${element(data.aws_subnet_ids.private.ids, 0)}"
	vpc_security_group_ids = [ 
		"${aws_security_group.infrastructure_nexus_ssh.id}"
	]
    associate_public_ip_address = true
  	provisioner "remote-exec" {
  		inline = [
    			"curl https://releases.rancher.com/install-docker/17.03.sh | sh",
    			"sudo docker run -d -p 80:8081 --name nexus sonatype/nexus:oss"
    		]
  		connection {
  			user			= "ubuntu"
        		private_key = "${file("Infrastructure.pem")}"
    		}
    }
}

#
resource "aws_route53_record" "infrastructure_nexus_route53_record" {
	zone_id 		= "Z13XION71XUTRJ"
  	name    		= "nexus"
  	type    		= "CNAME"
  	ttl			= 300
	records 		= [
		"${aws_instance.infrastructure_nexus.public_dns}"
	]
}