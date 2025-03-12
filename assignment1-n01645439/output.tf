
output "resource_group_name" {
  value = module.rgroup.resource_group_name
}

output "vnet_name" {
  value       = module.network-n01645439.virtual_network_name
  description = "The name of the virtual network"
}

output "subnet_id" {
  value       = module.network-n01645439.subnet_id
  description = "Subnet ID"
}

output "linux_vm_hostnames" {
  value       = module.linux-vms-n01645439.vm_hostnames
  description = "Linux VM hostnames"
}
