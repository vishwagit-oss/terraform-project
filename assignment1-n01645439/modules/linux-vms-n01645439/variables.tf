variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "rg_name" {
  description = "Resource group name"
  type        = string
  default     = "5439-resource-group"
}

variable "subnet_id" {
  description = "Subnet ID for the VMs"
  type        = string
}

variable "availability_set_name" {
  description = "Name of the availability set"
  type        = string
  default     = "5439-linux-avs"
}

variable "admin_username" {
  description = "Admin username for the VMs"
  type        = string
  default     = "adminuser"
}

variable "private_key_path" {
  description = "Path to the private key for SSH access"
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "vm_extensions" {
  description = "Extensions to install on the VMs"
  type = list(object({
    name                 = string
    publisher            = string
    type                 = string
    type_handler_version = string
  }))
  default =  [
    {
      name                 = "NetworkWatcherExtension"
      publisher            = "Microsoft.Azure.NetworkWatcher"
      type                 = "NetworkWatcherAgentLinux"
      type_handler_version = "1.4"
    },
    {
      name                 = "AzureMonitorExtension"
      publisher            = "Microsoft.Azure.Monitor"
      type                 = "AzureMonitorLinuxAgent"
      type_handler_version = "1.9"
    }
  ]
}
variable "vm_config" {
  description = "Configuration for each VM"
  type = map(object({
    size = string
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    domain_name_label = string
    assign_public_ip  = bool
  }))
  default = {
    "5439-linux-1" = {
      size = "Standard_B1s"
      source_image_reference = {
       publisher = "OpenLogic"
        offer     = "CentOS"
        sku       = "8_2"
        version   = "latest"
      }
      domain_name_label = "linux1-5439"
      assign_public_ip  = true
    },
    "5439-linux-2" = {
      size = "Standard_B1s"
      source_image_reference = {
       publisher = "OpenLogic"
        offer     = "CentOS"
        sku       = "8_2"
        version   = "latest"
      }
      domain_name_label = "linux2-5439"
      assign_public_ip  = true
    },
    "5439-linux-3" = {
      size = "Standard_B1s"
      source_image_reference = {
       publisher = "OpenLogic"
        offer     = "CentOS"
        sku       = "8_2"
        version   = "latest"
      }
      domain_name_label = "linux3-5439"
      assign_public_ip  = true
    }
  }
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
  default     = { "environment" = "dev", "owner" = "5439" }
}
