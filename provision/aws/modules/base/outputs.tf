output "subnet" {
   value = aws_subnet.demo_app_stack_public_subnet.id
}

output "security_group" {
   value = aws_security_group.demo_sg.id
}

output "ssh_key_name" {
   value = aws_key_pair.ssh_key.key_name
}
