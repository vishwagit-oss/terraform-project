output "vm_hostname" {
  description = "The hostname of the VM"
  value       = azurerm_windows_virtual_machine.windows_vm[*].name
}

output "vm_fqdns" {
  description = "The DNS name of the VM's public IP"
  value       = azurerm_public_ip.public_ip[*].fqdn
}

output "vm_private_ip_address" {
  description = "The private IP address of the VM"
  value       = azurerm_network_interface.network_interface[*].private_ip_address
}

output "vm_public_ip_address" {
  description = "The public IP address of the VM"
  value       = azurerm_public_ip.public_ip[*].ip_address
}

output "vm_ids" {
  description = "The IDs of the VM"
  value       = azurerm_windows_virtual_machine.windows_vm[*].id
}

output "vm_nics" {
  description = "The NICs of the VM"
  value       = azurerm_network_interface.network_interface[*].id
}