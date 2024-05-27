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

variable "network_acl_allow_rule_protocol" {
  type = string
}

variable "network_acl_allow_rule_https_port" {
  type = number
}

variable "network_acl_allow_rule_https_number" {
  type = number
}

variable "network_acl_allow_rule_http_port" {
  type = number
}

variable "network_acl_allow_rule_http_number" {
  type = number
}

variable "network_acl_allow_rule_action" {
  type = string
}

variable "network_acl_allow_rule_cidr_range" {
  type = string
}

variable "network_acl_deny_all_rule_protocol" {
  type = number
}

variable "network_acl_deny_all_rule_number" {
  type = number
}

variable "network_acl_deny_all_rule_port" {
  type = number
}

variable "network_acl_deny_all_rule_action" {
  type = string
}

variable "network_acl_deny_all_rule_cidr_range" {
  type = string
}