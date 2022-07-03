resource "aws_db_subnet_group" "subnet-gr-db" {
	name       = "subnet-gr-db"
	subnet_ids = [var.priv-subnet-ter, var.publ-subnet-ter]
	
	tags = {
		Name = "My DB subnet group"
	}
}

resource "aws_security_group" "sec-gr-db" {
  name 		= "sec-gr-db"
  vpc_id    = var.vpc-ter

  ingress {
    from_port   = var.in_port
    to_port     = var.in_port
    protocol    = "tcp"
    cidr_blocks = var.sg_rds_in_cidr_block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.sg_rds_en_cidr_block
  }
}

resource "aws_db_instance" "rds" {
	allocated_storage    = var.allocated_storage
	engine               = var.engine 
	engine_version       = var.engine_version
	instance_class       = var.instance_class
	name                 = var.name
	username             = var.user_name
	password             = var.pass
#	parameter_group_name = "rds.mysql5.7"
	skip_final_snapshot  = true

	publicly_accessible	 	= false
	vpc_security_group_ids	= ["${aws_security_group.sec-gr-db.id}"]
	db_subnet_group_name	= aws_db_subnet_group.subnet-gr-db.id
}

