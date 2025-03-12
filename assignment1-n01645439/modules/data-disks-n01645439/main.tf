resource "azurerm_managed_disk" "data_disks" {
  count                = length(var.vm_ids)
  name                 = "5439-data-disk-${count.index + 1}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = 10
  create_option        = "Empty"
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attachment" {
  count              = length(var.vm_ids)
  virtual_machine_id = var.vm_ids[count.index]
  managed_disk_id    = azurerm_managed_disk.data_disks[count.index].id
  lun                = count.index
  caching            = "ReadWrite"
  create_option      = "Attach"
}