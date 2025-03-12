variable "location" {
  description = "The Azure region to deploy the resources in"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "vm_ids" {
  description = "The list of VM IDs to attach the data disks to"
  type        = list(string)
}

variable "disk_size_gb" {
  description = "The size of each data disk in GB"
  type        = number
  default     = 10
}

variable "tags" {
  description = "value of the tags"
  type        = map(string)
}
