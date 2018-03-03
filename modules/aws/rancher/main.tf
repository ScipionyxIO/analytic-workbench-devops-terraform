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
    		Name = "Scipionyx Vpc" 
	}
}

#
data "aws_subnet" "rancher" {
	availability_zone 	= "us-east-2a"
	tags {
    		Environment 		= "${var.environment}",
    		Visibility		= "Public" 
	}
}

#
resource "aws_security_group" "rancher" {
    name = "infrastructure_sg_rancher"
    description = "Infrastructure Rancher"
    vpc_id      = "${data.aws_vpc.vpc.id}"
    ingress {
        from_port   = "80"
        to_port     = "80"
        protocol    = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        from_port   = "22"
        to_port     = "22"
        protocol    = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        from_port   = "9345"
        to_port     = "9345"
        protocol    = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        from_port   = "6443"
        to_port     = "6443"
        protocol    = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    	egress {
    		from_port       = 0
    		to_port         = 0
    		protocol        = "-1"
    		cidr_blocks     = ["0.0.0.0/0"]
  	}
    tags { 
    		Name = "Infrastructure Rancher" 
	}
}

resource "aws_instance" "rancher" {
	count						= 1
	ami          				= "${data.aws_ami.ubuntu.id}"
	instance_type 				= "t2.micro"
	key_name						= "${var.environment}"
	subnet_id 					= "${data.aws_subnet.rancher.id}" 
	vpc_security_group_ids 		= [ "${aws_security_group.rancher.id}" ]
    associate_public_ip_address 	= true
  	provisioner "remote-exec" {
  		inline = [
    			"curl https://releases.rancher.com/install-docker/17.03.sh | sh",
    			"sudo apt-get mysql-client",
    			## CREATE DATABASE rancher;
			## GRANT ALL PRIVILEGES ON rancher.* TO 'rancher'@'%' IDENTIFIED BY 'rancher' WITH GRANT OPTION;
    			"sudo docker run -d --restart=unless-stopped -p 80:8080 rancher/server --db-host ${var.db_host} --db-port ${var.db_port} --db-user ${var.db_user} --db-pass ${var.db_pass} --db-name ${var.db_name}"
    		]
  		connection {
  			user			= "ubuntu"
       		private_key = "${file("../Infrastructure.pem")}"
    		}
    }
    tags { 
   		Name = "Infrastructure-Rancher-${count.index}" 
   		Type = "Rancher Master"
   	}
}

data "aws_route53_zone" "infra" {
	name		= "scipionyx.org"
}

resource "aws_route53_record" "racher" {
	zone_id 		= "${data.aws_route53_zone.infra.zone_id}"
  	name    		= "rancher"
  	type    		= "CNAME"
  	ttl			= 300
	records 		= [
		"${aws_instance.rancher.public_dns}"
	]
}