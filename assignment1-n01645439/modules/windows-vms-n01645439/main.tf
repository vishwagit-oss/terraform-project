
resource "azurerm_availability_set" "availability_set" {
  name                         = var.availability_set_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  managed                      = true
  platform_fault_domain_count  = 3
  platform_update_domain_count = 5
  tags                         = var.tags
}

resource "azurerm_public_ip" "public_ip" {
  count               = var.vm_count
  name                = "${var.vm_name}-${count.index + 1}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  domain_name_label   = "${var.dns_label}-${count.index}"
  tags                = var.tags
}

resource "azurerm_network_interface" "network_interface" {
  count               = var.vm_count
  name                = "${var.vm_name}-${count.index + 1}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[count.index].id
  }
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  count                 = var.vm_count
  name                  = "${var.vm_name}-${count.index + 1}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  availability_set_id   = azurerm_availability_set.availability_set.id
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.network_interface[count.index].id]
  tags                  = var.tags

  os_disk {
    name                 = "${var.vm_name}-${count.index + 1}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  boot_diagnostics {
    storage_account_uri = var.storage_account_url
  }

  winrm_listener {
    protocol = "Http"
  }

}

