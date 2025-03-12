variable "location" {
  description = "The Azure location for resources."
  type        = string
  default     = "East US"
}

variable "admin_username" {
  description = "The admin username for the Linux VMs."
  type        = string
  default     = "adminuser"
}

variable "admin_password" {
  description = "The admin password for the Linux VMs."
  type        = string
  default     = "Secure@1234!"
}


variable "vm_size" {
  description = "The size of the Linux VMs."
  type        = string
  default     = "Standard_B1s"
}

