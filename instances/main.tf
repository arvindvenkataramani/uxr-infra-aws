provider "aws" {
  region = "us-east-2"
}

# Use data from the environment module
data "terraform_remote_state" "env" {
  backend = "local"
  config = {
    path = "../env-setup/terraform.tfstate"
  }
}

# Generate a list of unique keys for the random_password resources
locals {
  instance_keys = [for i in range(var.instance_count) : tostring(i)]
}

resource "random_password" "uxrops_password" {
  length  = var.password_length
  special = true
  override_special = var.override_special_list
}

resource "random_password" "testuser_password" {
  for_each = toset(local.instance_keys)
  length = var.password_length
  special = true
  override_special = var.override_special_list
}

# Create EC2 instances
resource "aws_instance" "linux_vm" {
#   count         = var.instance_count # before using for_each
  for_each = toset(local.instance_keys)
  ami           = "ami-09efc42336106d2f2"  # Amazon Linux 2 AMI (adjust for region)
  instance_type = "t2.nano"
  key_name      = var.key_name
  subnet_id     = data.terraform_remote_state.env.outputs.subnet_id
  vpc_security_group_ids = [data.terraform_remote_state.env.outputs.security_group_id]


  user_data = <<-EOF
              #!/bin/bash
              # Create 'uxrops' user with sudo privileges
              useradd -m -s /bin/bash uxrops
              echo "uxrops:${random_password.uxrops_password.result}" | chpasswd
              echo "uxrops ALL=(ALL) ALL" >> /etc/sudoers

              # Create 'testuser' user with a unique password
              useradd -m -s /bin/bash testuser
              echo "testuser:${random_password.testuser_password[each.key].result}" | chpasswd
              echo "testuser ALL=(ALL) ALL" >> /etc/sudoers

              # Ensure password authentication is enabled for SSH
              sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
              systemctl restart sshd
              EOF

  tags = {
    Name = "linux-vm-${each.key}"
    Key  = each.key
  }
}
