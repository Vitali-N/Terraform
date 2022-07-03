output "id-security-group-Bastion-host" {
    description = "id security group Bastion host:"
    value = aws_security_group.bastion_host.id
}

output "id-security-group-Private-host" {
    description = "id security group Private host:"
    value = aws_security_group.private_host.id
}
