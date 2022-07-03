provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
    source  = "./modules/vpc"

	cidr_block_vpc			= var.cidr_block_vpc
	cidr_block_publ_subnet		= var.cidr_block_publ_subnet
	cidr_block_priv_subnet		= var.cidr_block_priv_subnet

	availability_zones		= var.availability_zones
}

module "sec-groups" {
        source	= "./modules/sec-gr"
		
		vpc-ter 			= module.vpc.vpc-ter 
		
		bastion_host_in_cidr_blocks	= var.bastion_host_in_cidr_blocks
		bastion_host_eg_cidr_blocks	= var.bastion_host_eg_cidr_blocks
		private_host_in_cidr_blocks	= var.private_host_in_cidr_blocks
		private_host_eg_cidr_blocks	= var.private_host_eg_cidr_blocks
		
		depends_on	= [module.vpc]
}

module "two-server" {
		source	= "./modules/two-server"
		
		instance_type	= var.instance_type
		ami_instance	= var.ami_instance
		publ-key	= var.publ-key

		publ-subnet-ter			= module.vpc.publ-subnet-ter
		priv-subnet-ter			= module.vpc.priv-subnet-ter
		id-security-group-Bastion-host 	= module.sec-groups.id-security-group-Bastion-host	
		id-security-group-Private-host 	= module.sec-groups.id-security-group-Private-host
		
		depends_on	= [module.sec-groups]
}

module "rds" {
		source  = "./modules/rds"

		in_port		     = var.in_port
		sg_rds_in_cidr_block = var.sg_rds_in_cidr_block
		sg_rds_en_cidr_block = var.sg_rds_en_cidr_block

		allocated_storage	= var.allocated_storage
		engine			= var.allocated_storage
		engine_version		= var.engine_version
		instance_class		= var.instance_class
		name			= var.name
		user_name		= var.user_name
		pass			= var.pass

		vpc-ter			= module.vpc.vpc-ter
		priv-subnet-ter		= module.vpc.priv-subnet-ter
		publ-subnet-ter		= module.vpc.publ-subnet-ter
		
		depends_on	= [module.two-server]
}

