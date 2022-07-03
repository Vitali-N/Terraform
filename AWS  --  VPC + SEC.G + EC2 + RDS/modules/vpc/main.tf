#aws_vpc
resource "aws_vpc" "vpc-ter" {
        cidr_block = var.cidr_block_vpc
        
        tags = {
        Name = "vpc-ter"
        }
}

#aws_availability_zones
data "aws_availability_zones" "available" {
}

locals {
  availables_zones_list = join(", ", aws_subnet.publ-subnet-ter[*].availability_zone)
}

#publ-subnet
resource "aws_subnet" "publ-subnet-ter" {
    count                   = length(var.cidr_block_publ_subnet)  
    vpc_id                  = "${aws_vpc.vpc-ter.id}"
    cidr_block              = element(var.cidr_block_publ_subnet, count.index)
    availability_zone       = data.aws_availability_zones.available.names[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "publ-subnet-ter"
    }
}

#priv-subnet
resource "aws_subnet" "priv-subnet-ter" {
    count                   = length(var.cidr_block_priv_subnet) 
    vpc_id                  = "${aws_vpc.vpc-ter.id}"
    cidr_block              = element(var.cidr_block_priv_subnet, count.index)
	availability_zone       = data.aws_availability_zones.available.names[count.index]
    map_public_ip_on_launch = false

    tags = {
        Name = "priv-subnet-ter"
    }
}

#igw
resource "aws_internet_gateway" "igw-ter" {
    vpc_id = "${aws_vpc.vpc-ter.id}"
}

# elastic ip for the nat gateway
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw-ter]
}

#nat
resource "aws_nat_gateway" "nat" {
	count         = length(var.cidr_block_priv_subnet)
	allocation_id = "${aws_eip.nat_eip.id}"
    subnet_id     = element(aws_subnet.publ-subnet-ter[*].id, count.index)
	
    depends_on    = [aws_internet_gateway.igw-ter]
	
    tags = {
		Name = "nat"
	}
}

#route-table-publ
resource "aws_route_table" "route-tbl-publ-ter" {
    vpc_id = "${aws_vpc.vpc-ter.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw-ter.id}"
    }

    tags = {
        Name = "route-tbl-publ-ter"
    }
}

#route-table-priv
resource "aws_route_table" "route-tbl-priv-ter" {
    count  = length(var.cidr_block_priv_subnet)
    vpc_id = "${aws_vpc.vpc-ter.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat[count.index].id
    }

    tags = {
        Name = "route-tbl-priv-ter"
    }
}

#route_table_association-publ
resource "aws_route_table_association" "publ-rt-assoc" {
    count         	= length(aws_subnet.publ-subnet-ter[*].id)
    subnet_id 		= element(aws_subnet.publ-subnet-ter[*].id, count.index)
    route_table_id 	= aws_route_table.route-tbl-publ-ter.id
}

#route_table_association-priv
resource "aws_route_table_association" "priv-rt-assoc" {
    count         	= length(aws_subnet.priv-subnet-ter[*].id)
    subnet_id 		= element(aws_subnet.priv-subnet-ter[*].id, count.index)
    route_table_id 	= aws_route_table.route-tbl-priv-ter[count.index].id
}

