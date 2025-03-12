variable "location" {
  description = "The Azure region to deploy the resources in"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "availability_set_name" {
  description = "Name of the availability set"
  type        = string
  default     = "5439-windows-avs"
}

variable "vm_count" {
  description = "The number of VMs to create"
  type        = number
  default     = 1
}

variable "vm_name" {
  description = "The name of the VM"
  type        = string
  default     = "5439-win-vm"

}

variable "vm_size" {
  description = "The size of the VM"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "admin_username" {
  description = "The admin username for the VM"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the VM"
  type        = string
  sensitive   = true
}

variable "storage_account_url" {
  description = "The URL of the storage account for boot diagnostics"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID where the VMs will be placed"
  type        = string
}

variable "dns_label" {
  description = "The DNS label to use for the VM"
  type        = string
  default     = "n01645439-w-vm"
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default = {
    environment = "dev"
    owner       = "5439"
  }
}
