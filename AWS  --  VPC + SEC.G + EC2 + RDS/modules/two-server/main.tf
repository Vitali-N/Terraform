resource "aws_key_pair" "key" {
	key_name   = "ter-2"
	public_key = var.publ-key
}

resource "aws_instance" "bastion-host" {
        ami                         = var.ami_instance
        instance_type               = var.instance_type
        key_name		    		= "ter-2"
        associate_public_ip_address = true
        subnet_id                   = var.publ-subnet-ter
		vpc_security_group_ids	    = [var.id-security-group-Bastion-host]

        tags = {
                Name = "bastion-host"
        }
}

resource "aws_instance" "private-host" {
        ami							= var.ami_instance
        instance_type				= var.instance_type
        subnet_id					= var.priv-subnet-ter
		key_name					= "ter-2"
		vpc_security_group_ids  	= [var.id-security-group-Private-host]
		associate_public_ip_address = false

        tags = {
                Name = "private-host"
        }

}
