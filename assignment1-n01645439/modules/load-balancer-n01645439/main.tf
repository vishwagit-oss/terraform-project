resource "azurerm_lb" "loadbalancer" {
  name                = "5439-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"
  frontend_ip_configuration {
    name                 = "PublicFrontend"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
  tags = var.tags
}

resource "azurerm_public_ip" "lb_public_ip" {
  name                = "5439-lb-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  domain_name_label   = var.dns_label
  tags                = var.tags
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name            = "5439-lb-backend-pool"
  loadbalancer_id = azurerm_lb.loadbalancer.id
}

resource "azurerm_lb_probe" "health_probe" {
  name                = "5439-lb-healthProbe"
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 15
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "lb_rule" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.loadbalancer.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool.id]
  probe_id                       = azurerm_lb_probe.health_probe.id
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_association" {
  count                   = length(var.vm_nic_ids)
  network_interface_id    = var.vm_nic_ids[count.index]
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
  ip_configuration_name   = "internal"
}
