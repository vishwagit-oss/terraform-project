resource "azurerm_availability_set" "availability_set" {
  name                         = var.availability_set_name
  location                     = var.location
  resource_group_name          = var.rg_name
  managed                      = true
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  tags                         = var.tags
}

resource "azurerm_public_ip" "public_ip" {
  for_each            = var.vm_config
  name                = "${each.key}-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Basic"
  domain_name_label   = each.value.domain_name_label
  tags                = var.tags
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.vm_config
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_id
    public_ip_address_id          = azurerm_public_ip.public_ip[each.key].id
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each            = var.vm_config
  name                = each.key
  location            = var.location
  resource_group_name = var.rg_name
  size                = each.value.size
  admin_username      = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]

  availability_set_id = azurerm_availability_set.availability_set.id

  os_disk {
    name                 = "${each.key}-os-disk"
    caching              = "ReadWrite"
    disk_size_gb         = 30
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {

    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "linux_extensions_1" {
  for_each             = var.vm_config
  name                 = "NetworkWatcherExtension"
  virtual_machine_id   = azurerm_linux_virtual_machine.linux_vm[each.key].id
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"

  depends_on = [azurerm_linux_virtual_machine.linux_vm]
  tags       = var.tags
}

resource "azurerm_virtual_machine_extension" "linux_extensions_2" {
  for_each             = var.vm_config
  name                 = "AzureMonitorExtension"
  virtual_machine_id   = azurerm_linux_virtual_machine.linux_vm[each.key].id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.9"

  depends_on = [azurerm_linux_virtual_machine.linux_vm]
  tags       = var.tags
}