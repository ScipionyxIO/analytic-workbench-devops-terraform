# Configure the AWS Provider

data "aws_vpc" "vpc" {
	tags { Name = "${var.vpc_name}" }
}

data "aws_security_group" "private" {
	tags {
    		Environment 	= "${var.environment}",
    		Type			= "RDS"
	}
}

resource "aws_db_instance" "mariadb" {
	allocated_storage   			= 10
	storage_type        			= "gp2"
	engine              			= "mariadb"
	engine_version      			= "10.2.11"
	instance_class      			= "db.t2.micro"
	name                			= "${var.rds_database_name}"
	identifier					= "${var.rds_database_name}"
	final_snapshot_identifier 	= "${var.rds_database_name}-fs"
	username            			= "${var.rds_user}"
	password            			= "${var.rds_password}"
	publicly_accessible			= false
	db_subnet_group_name			= "${var.db_subnet_group_name}"
	vpc_security_group_ids  		= [
		"${data.aws_security_group.private.id}"
	]
}