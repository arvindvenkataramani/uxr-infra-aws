# Terraform AWS Virtual Machine Repository

This is a set of Terraform scripts to quickly spin up and down AWS EC2 and EKS instances for use in usability testing and friction-logging sessions.

## Table of Contents
1. [Repository Structure](#repository-structure)
2. [Key Components](#key-components)
3. [Usage Instructions](#usage-instructions)
4. [Contributing Guidelines](#contributing-guidelines)
5. [License](#license)

## Repository Structure
The repository is organized as follows:
- `/instances`: Contains Terraform configuration files to define and manage AWS instances.
- `/env-setup`: Contains Terraform configuration files for setting up the environment, including VPC, subnets, and security groups.

## Key Components
- **`instances/main.tf`**: Main Terraform configuration file defining AWS providers, data sources, local variables, resources (EC2 instances), and user data for password setup.
- **`instances/variables.tf`**: Defines input variables used across multiple files in the `instances` directory.
- **`env-setup/main.tf`**: Configuration to set up VPC, subnets, internet gateway, route table, security group, and outputs necessary IDs for use in instance configuration.
- **`env-setup/outputs.tf`**: formats outputs for listing the created resources and their access credentials

## Usage Instructions
`terraform apply`
`terraform destroy`

## Contributing Guidelines
Contributions are welcome! Please read the [CONTRIBUTING.md](CONTRIBUTING.md) file for guidelines on how to contribute to this project.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.