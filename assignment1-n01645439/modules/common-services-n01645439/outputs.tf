output "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.log_analytics.id
}

output "log_analytics_workspace_name" {
  description = "The name of the Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.log_analytics.name
}

output "recovery_vault_id" {
  description = "The ID of the Recovery Vault."
  value       = azurerm_recovery_services_vault.recovery_vault.id
}

output "recovery_vault_name" {
  description = "The name of the Recovery Vault."
  value       = azurerm_recovery_services_vault.recovery_vault.name
}

output "storage_account_id" {
  description = "The ID of the Storage Account."
  value       = azurerm_storage_account.storage_account.id
}

output "storage_account_name" {
  description = "The name of the Storage Account."
  value       = azurerm_storage_account.storage_account.name
}

output "storage_account_primary_blob_endpoint" {
  description = "The primary blob endpoint of the Storage Account."
  value       = azurerm_storage_account.storage_account.primary_blob_endpoint
}
