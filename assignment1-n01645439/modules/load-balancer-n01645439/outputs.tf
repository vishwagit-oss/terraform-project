output "loadbalancer_name" {
  description = "The name of the load balancer"
  value       = azurerm_lb.loadbalancer.name
}

output "public_ip_address" {
  description = "The public IP address of the load balancer"
  value       = azurerm_public_ip.lb_public_ip.ip_address
}

output "fqdn" {
  description = "value of the FQDN"
  value       = azurerm_public_ip.lb_public_ip.fqdn
}