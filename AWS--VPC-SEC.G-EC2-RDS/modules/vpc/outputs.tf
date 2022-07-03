#vpc
output "vpc-ter" {
        value 	        = aws_vpc.vpc-ter.id
        description     = "vpc-ter-id"
}

output "availables_zones_list" {
  value = local.availables_zones_list
}

#publ-subnet
output "publ-subnet-ter" {
        value 		= aws_subnet.publ-subnet-ter[*].id
        description     = "publ-subnet-ter-id"
}

#priv-subnet
output "priv-subnet-ter" {
        value 		= aws_subnet.priv-subnet-ter[*].id
        description     = "priv-subnet-ter-id"
}

#igw-ter
output "aws-internet-gateway" {
        value       = aws_internet_gateway.igw-ter.id
        description = "aws-internet-gateway-id"
}

#nat
output "nat" {
        value       = aws_nat_gateway.nat[*].id
        description = "description"
}

#route-tbl-publ
output "route-tbl-publ-ter" {
        value       = aws_route_table.route-tbl-publ-ter.id
        description = "route-tbl-publ-ter"
}

#route-tbl-priv
output "route-tbl-priv-ter" {
        value       = aws_route_table.route-tbl-priv-ter[*].id
        description = "route-tbl-priv-ter"
}

#priv-rt-assoc
output "priv-rt-assoc-id" {
        value       = aws_route_table_association.priv-rt-assoc[*].id
        description = "priv-rt-assoc-id"
}

#publ-rt-assoc
output "publ-rt-assoc-id" {
        value       = aws_route_table_association.publ-rt-assoc[*].id
        description = "publ-rt-assoc-id"
}