variable "vnet_name" {
  description = "The name of the Virtual Network."
  type        = string
}

variable "vnet_address_space" {
  description = "The address space of the Virtual Network."
  type        = list(string)
}

variable "subnet_name" {
  description = "The name of the Subnet."
  type        = string
}

variable "subnet_address_prefix" {
  description = "The address prefix for the Subnet."
  type        = string
}

variable "nsg_name" {
  description = "The name of the Network Security Group."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "tags" {
  description = "value of the tags"
  type        = map(string)
}
