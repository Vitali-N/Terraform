#credits
variable "region" {
  type        = string
  default     = "eu-central-1"
  description = "region AWS default"
}

variable "access_key" {
  type        = string
  default     = "AKIASXXXXXXXXXXXXXXXXXX"
  description = "access_key"
}

variable "secret_key" {
  type        = string
  default     = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  description = "secret_key"
}


#vpc
#variable "vpc-ter" {
#}
/*variable "availability_zone" {
  default     = ["eu-central-1a"]
  type        = list
}
*/
variable "availability_zones" {
    default     = ["eu-central-1a","eu-central-1b","eu-central-1c","eu-centralt-1e"]
    type        = list
}

variable "cidr_block_vpc" {
  default     = "10.0.0.0/16"
  type        = string
}

variable "cidr_block_publ_subnet" {
  default     = ["10.0.10.0/24"]
  type        = list
}

variable "cidr_block_priv_subnet" {
  default     = ["10.0.20.0/24"]
  type        = list   
}



#sec-gr
variable "cidr_blocks_ingress" {
	default	= ["10.0.0.0/16"]
}

variable "bastion_host_in_cidr_blocks" {
  type        = list
  default     = ["0.0.0.0/0"]
  description = "SSH -22"
}

variable "bastion_host_eg_cidr_blocks" {
  type        = list
  default     = ["0.0.0.0/0"]
  description = "all protocols all ports"
}

variable "private_host_in_cidr_blocks" {
  type        = list
  default     = ["0.0.0.0/0"]
  description = "all protocols all ports"
}

variable "private_host_eg_cidr_blocks" {
  type        = list
  default     = ["0.0.0.0/0"]
  description = "all protocols all ports"
}


#two-server
variable "instance_type" {
      type        = string
      default     = "t2.micro"
      description = "instance type"
}

variable "ami_instance" {
      type        = string
      default     = "ami-XXXXXXXXXXXXXXXXX"
      description = "ami_instance"
}

variable "publ-key" {
      type        = string
      default     = "ssh-rsa XXXXXXXXXXXXXXXXX Imported-Openssh-Key"
}


#rds
variable "in_port" {
	default = "3306"
}

variable "sg_rds_in_cidr_block" {
	type    = list
  default = ["10.0.0.0/16"]
}

variable "sg_rds_en_cidr_block" {
	type    = list
  default = ["0.0.0.0/0"]
}

variable "allocated_storage" {
  default = "10"
}

variable "engine" {
  default = "mysql"
}

variable "engine_version" {
  default = "5.7"
}

variable "instance_class" {
	default = "db.t2.micro"
}

variable "name" {
  default = "mydb"
}

variable "user_name" {
	default = "user"
}

variable "pass" {
	default = "123456789"
}









