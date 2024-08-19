# Jenkins Infra using Terraform

This repo contains Infrastructure as code(Terraform) files to setup Jenkins on AWS.

## Installation

Please follow the installation instructions required for setting up the project [here](INSTALLATION.md).

## Setup Terraform in repo

To set up Terraform within your repository, follow these steps:

1. **Navigate to Repository**: Open a terminal or command prompt and navigate to the root directory of the repository.
2. **Initialize Terraform**: Run terraform init to initialize Terraform within the repository. This command initializes various Terraform configurations and plugins required for your infrastructure.

        $ terraform init
        Initializing the backend...

        Initializing provider plugins...
        - Reusing previous version of hashicorp/aws from the dependency lock file
        - Installing hashicorp/aws v5.51.1...
        - Installed hashicorp/aws v5.51.1 (signed by HashiCorp)
        ...
        Terraform has been successfully initialized!

3. **Plan Infrastructure Changes**: After initialization, you can run terraform plan to see what changes Terraform will make to your infrastructure. Use -var-file to specify a variable file if needed.

        terraform plan

4. **Apply Infrastructure Changes**: If the plan looks good, you can apply the changes by running terraform apply. Use -var-file to specify a variable file if needed.

        terraform apply

5. **Destroy Infrastructure**: To destroy the infrastructure created by Terraform, you can run terraform destroy. Make sure to review the plan before proceeding.

        terraform destroy

## What's in  this repo

This repo contains the following files:

- `provider.tf`: This file contains the terraform code to setup Jenkins on AWS.
- `variables.tf`: This file contains the variables required for the terraform code.
- `vpc.tf`: This file contains the terraform code to setup the VPC, Subnet, Internet Gateway, Route Table, and Security Group on AWS.
- `ec2.tf`: This file contains the terraform code to setup the EC2 to host Jenkins instance from AMI on AWS.

## Usage

The following variables are required to create a VPC via terraform.

| Variable                                   | Type   | Description                                          |
| ------------------------------------------ | ------ | ---------------------------------------------------- |
| `region`                                   | string | The region where the VPC will be created.            |
| `vpc_name`                                 | string | The name of the VPC.                                 |
| `vpc_cidr_range`                           | string | The CIDR range for the VPC.                          |
| `subnet_name`                              | string | The name of the subnet.                              |
| `subnet_cidr_range`                        | string | The CIDR range for the subnet.                       |
| `subnet_zone`                              | string | The availability zone for the subnet.                |
| `internet_gateway_name`                    | string | The name of the internet gateway.                    |
| `route_table_name`                         | string | The name of the route table.                         |
| `route_cidr`                               | string | The CIDR block for the route table.                  |
| `network_acl_ingress`                      | list   |                                                      |
| `network_acl_ingress[protocol]`            | string | The protocol for the network ACL ingress.            |
| `network_acl_ingress[port]`                | string | The port for the network ACL ingress.                |
| `network_acl_ingress[number]`              | string | The rule number for the network ACL ingress.         |
| `network_acl_ingress[action]`              | string | The action for the network ACL ingress.              |
| `network_acl_ingress[cidr]`                | string | The CIDR block for the network ACL ingress.          |
| `network_acl_egress`                       | list   |                                                      |
| `network_acl_egress[protocol]`             | string | The protocol for the network ACL egress.             |
| `network_acl_egress[port]`                 | string | The port for the network ACL egress.                 |
| `network_acl_egress[number]`               | string | The rule number for the network ACL egress.          |
| `network_acl_egress[action]`               | string | The action for the network ACL egress.               |
| `network_acl_egress[cidr]`                 | string | The CIDR block for the network ACL egress.           |
| `jenkins_security_group_name`              | string | The name of the security group.                      |
| `jenkins_security_group_ingress`           | list   |                                                      |
| `jenkins_security_group_ingress[protocol]` | string | The protocol for the security group ingress rules.   |
| `jenkins_security_group_ingress[port]`     | string | The port for the security group ingress rules.       |
| `jenkins_security_group_ingress[cidr]`     | string | The CIDR block for the security group ingress rules. |
| `jenkins_ec2`                              | object |                                                      |
| `jenkins_ec2[ami]`                         | string | The AMI ID for the Jenkins EC2 instance.             |
| `jenkins_ec2[instance_name]`               | string | The name of the Jenkins EC2 instance.                |
| `jenkins_ec2[instance_type]`               | string | The instance type for the Jenkins EC2 instance.      |
| `jenkins_ec2[associate_public_ip_address]` | string | Whether to associate a public IP address or not.     |
| `jenkins_ec2[volume]`                      | object |                                                      |
| `jenkins_ec2[volume][size]`                | string | The size of the volume.                              |
| `jenkins_ec2[volume][type]`                | string | The type of the volume.                              |
| `jenkins_ec2_eip_allocation_id`            | string | The allocation ID for the Elastic IP.                |
