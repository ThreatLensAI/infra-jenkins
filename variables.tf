variable "region" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "vpc_cidr_range" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "subnet_cidr_range" {
  type = string
}

variable "subnet_zone" {
  type = string
}

variable "route_cidr" {
  type = string
}

variable "internet_gateway_name" {
  type = string
}

variable "route_table_name" {
  type = string
}

variable "network_acl_ingress" {
  type = list(object({
    protocol = string
    port     = number
    number   = number
    action   = string
    cidr     = string
  }))
}

variable "network_acl_egress" {
  type = list(object({
    protocol = string
    port     = number
    number   = number
    action   = string
    cidr     = string
  }))
}

variable "jenkins_ami_filter_name" {
  type = string
}

variable "jenkins_ami_filter_value" {
  type = string
}

variable "jenkins_security_group_name" {
  type = string
}

variable "jenkins_security_group_ingress_rules" {
  type = map(object({
    protocol = string
    port     = number
    cidr     = string
  }))
}

variable "ec2_instance_name" {
  type = string
}

variable "ec2_instance_type" {
  type = string
}

variable "ec2_associate_public_ip_address" {
  type = bool
}

variable "ec2_root_volume_size" {
  type = number
}

variable "ec2_root_volume_type" {
  type = string
}

variable "eip_allocation_id" {
  type = string
}