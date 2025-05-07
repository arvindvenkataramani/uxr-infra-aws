# output "instance_ips" {
#   value = aws_instance.linux_vm[*].public_ip
# }

# output "testuser_passwords" {
#   sensitive = true
#   value = { for i in aws_instance.linux_vm : i.public_ip => random_password.testuser_password[i.id].result }
# }


# output "instance_ips" {
#   value = aws_instance.linux_vm[*].public_ip
# }

# output "testuser_passwords" {
#   sensitive = true
#   value = random_password.testuser_password[*].result
# }

output "uxrops_password" {
  value = random_password.uxrops_password.result
  sensitive = true
}

output "instance_info" {
  value = {
    for instance in aws_instance.linux_vm :
    instance.tags["Name"] => "${instance.public_ip} : testuser | ${random_password.testuser_password[instance.tags["Key"]].result}"
  }
  sensitive = true
}