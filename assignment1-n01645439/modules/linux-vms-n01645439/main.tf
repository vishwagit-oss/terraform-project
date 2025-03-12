locals {
  extensions_for_each_vm = flatten([
    for vm_name, vm_config in var.vm_config : [
      for extension in var.vm_extensions : {
        vm_name   = vm_name
        extension = extension
      }
    ]
  ])
}

resource "random_id" "boot_diag" {
  byte_length = 4
}

resource "azurerm_storage_account" "boot_diag" {
  name                     = "bootdiag${random_id.boot_diag.hex}"
  location                 = var.location
  resource_group_name      = var.rg_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

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
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }
  


  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.boot_diag.primary_blob_endpoint
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "linux_extensions" {
  for_each = { for idx, ext in local.extensions_for_each_vm : idx => ext }

  name                 = each.value.extension.name
  virtual_machine_id   = azurerm_linux_virtual_machine.linux_vm[each.value.vm_name].id
  publisher            = each.value.extension.publisher
  type                 = each.value.extension.type
  type_handler_version = each.value.extension.type_handler_version

  depends_on = [azurerm_linux_virtual_machine.linux_vm]
  tags       = var.tags
}
