
#
data "aws_vpc" "vpc" {
	tags {
    		Name = "Scipionyx Vpc" 
	}
}

#
resource "aws_security_group" "k8" {
    name = "infrastructure_sg_k8_node"
    description = "Infrastructure K8 Node"
    vpc_id      = "${data.aws_vpc.vpc.id}"
    ingress {
        from_port   = "80"
        to_port     = "80"
        protocol    = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        from_port   = "443"
        to_port     = "443"
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
        from_port   = "500"
        to_port     = "500"
        protocol    = "udp"
        cidr_blocks = [ "10.0.0.0/16" ]
    }
    ingress {
        from_port   = "4500"
        to_port     = "4500"
        protocol    = "udp"
        cidr_blocks = [ "10.0.0.0/16" ]
    }
    ingress {
        from_port   = "8081"
        to_port     = "8081"
        protocol    = "tcp"
        cidr_blocks = [ "10.0.0.0/16" ]
    }
    ingress {
        from_port   = "10250"
        to_port     = "10250"
        protocol    = "tcp"
        cidr_blocks = [ "10.0.0.0/16" ]
    }
    ingress {
        from_port   = "10255"
        to_port     = "10255"
        protocol    = "tcp"
        cidr_blocks = [ "10.0.0.0/16" ]
    }
    ingress {
        from_port   = "30000"
        to_port     = "32767"
        protocol    = "tcp"
        cidr_blocks = [ "10.0.0.0/16" ]
    }
    	egress {
    		from_port       = 0
    		to_port         = 0
    		protocol        = "-1"
    		cidr_blocks     = ["0.0.0.0/0"]
  	}
    tags { Name = "Infrastructure K8 Node" }
}

