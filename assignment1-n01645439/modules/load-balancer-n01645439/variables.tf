variable "location" {
  description = "The Azure region to deploy the resources in"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "vm_nic_ids" {
  description = "The list of VM NIC IDs to attach to the load balancer backend pool"
  type        = list(string)
}

variable "dns_label" {
  description = "The DNS label to use for the load balancer's public IP"
  type        = string
  default     = "n01645439-lb-1"
}

variable "tags" {
  description = "value of the tags"
  type        = map(string)
}
