
output "disk_ids" {
  description = "The IDs of the created data disks"
  value       = azurerm_managed_disk.data_disks[*].id
}

output "disk_names" {
  description = "The names of the created data disks"
  value       = azurerm_managed_disk.data_disks[*].name
}
