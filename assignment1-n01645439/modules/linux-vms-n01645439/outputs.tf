output "availability_set_name" {
  value       = azurerm_availability_set.availability_set.name
  description = "The name of the Linux Availability Set"
}

output "vm_hostnames" {
  description = "The hostnames of the Linux virtual machines"
  value       = values(azurerm_linux_virtual_machine.linux_vm)[*].name
}

output "vm_private_ips" {
  description = "The private IP addresses of the Linux virtual machines"
  value       = values(azurerm_network_interface.nic)[*].private_ip_address
}

output "vm_public_ips" {
  description = "The public IP addresses of the Linux virtual machines"
  value       = values(azurerm_public_ip.public_ip)[*].ip_address
}

output "storage_account_name" {
  description = "Name of the storage account used for boot diagnostics"
  value       = azurerm_storage_account.boot_diag.name
}
