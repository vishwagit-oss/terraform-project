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
  default = [
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
    size              = string
    domain_name_label = string
  }))
  default = {
    "5439-linux-vm-1" = {
      size              = "Standard_B1s"
      domain_name_label = "n01645439-cnt-vm-1"
    },
    "5439-linux-vm-2" = {
      size              = "Standard_B1s"
      domain_name_label = "n01645439-cnt-vm-2"
    },
    "5439-linux-vm-3" = {
      size              = "Standard_B1s"
      domain_name_label = "n01645439-cnt-vm-3"
    },

  }
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
  default     = { "environment" = "dev", "owner" = "5439" }
}

variable "storage_account_uri" {
  description = "URI of the storage account for boot diagnostics"
  type        = string
}
