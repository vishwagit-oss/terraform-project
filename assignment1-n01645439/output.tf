
output "resource_group_name" {
  value       = module.rgroup.resource_group_name
  description = "value of the resource group name"
}

output "vnet_name" {
  value       = module.network-n01645439.virtual_network_name
  description = "The name of the virtual network"
}

output "subnet_name" {
  value       = module.network-n01645439.subnet_name
  description = "Subnet Name"
}

output "log_analytics_workspace_name" {
  value       = module.common-services-n01645439.log_analytics_workspace_name
  description = "The name of the Log Analytics workspace."
}

output "recovery_vault_name" {
  value       = module.common-services-n01645439.recovery_vault_name
  description = "The name of the Recovery Vault."
}

output "storage_account_name" {
  value       = module.common-services-n01645439.storage_account_name
  description = "The name of the Storage Account."
}

output "linux_vm_hostnames" {
  value       = module.linux-vms-n01645439.vm_hostnames
  description = "Linux VM hostnames"
}

output "linux_vm_private_ips" {
  value       = module.linux-vms-n01645439.vm_private_ips
  description = "Linux VM private IPs"
}

output "linux_vm_public_ips" {
  value       = module.linux-vms-n01645439.vm_public_ips
  description = "Linux VM public IPs"
}

output "linux_vm_fqdns" {
  value       = module.linux-vms-n01645439.vm_fqdns
  description = "Linux VM FQDNs"
}

output "windows_vm_hostname" {
  value       = module.windows-vms-n01645439.vm_hostname
  description = "The hostname of the VM"
}

output "windows_vm_fqdns" {
  value       = module.windows-vms-n01645439.vm_fqdns
  description = "The DNS name of the VM's public IP"
}

output "windows_vm_private_ip_address" {
  value       = module.windows-vms-n01645439.vm_private_ip_address
  description = "The private IP address of the VM"
}

output "windows_vm_public_ip_address" {
  value       = module.windows-vms-n01645439.vm_public_ip_address
  description = "The public IP address of the VM"
}

output "load_balancer_name" {
  value       = module.load-balancer-n01645439.loadbalancer_name
  description = "The name of the load balancer"
}

output "load_balancer_public_ip" {
  value       = module.load-balancer-n01645439.public_ip_address
  description = "The public IP address of the load balancer"
}

output "load_balancer_fqdn" {
  value       = module.load-balancer-n01645439.fqdn
  description = "value of the FQDN"
}

output "db_server_name" {
  value       = module.database-n01645439.db_server_name
  description = "The name of the PostgreSQL server"
}

output "db_name" {
  value       = module.database-n01645439.db_name
  description = "The name of the PostgreSQL database"
}
