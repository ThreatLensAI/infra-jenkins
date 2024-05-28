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

variable "internet_gateway_name" {
  type = string
}

variable "route_table_name" {
  type = string
}

variable "route_cidr" {
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

variable "jenkins_security_group_name" {
  type = string
}

variable "jenkins_security_group_ingress" {
  type = list(object({
    protocol = string
    port     = number
    cidr     = string
  }))
}

variable "jenkins_ec2" {
  type = object({
    ami = string

    instance_name = string
    instance_type = string

    associate_public_ip_address = optional(bool, true)
    volume = object({
      size = number
      type = string
    })
  })
}

variable "jenkins_ec2_eip_allocation_id" {
  type = string
}
