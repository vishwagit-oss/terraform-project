# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "5439-log-analytics"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"

  retention_in_days = 30
  tags              = var.tags
}

# Recovery Vault
resource "azurerm_recovery_services_vault" "recovery_vault" {
  name                = "recoveryvault5439"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags                = var.tags
}

# Storage Account
resource "azurerm_storage_account" "storage_account" {
  name                     = "5439storageacc"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}
