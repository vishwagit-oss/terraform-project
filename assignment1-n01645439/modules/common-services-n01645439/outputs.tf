output "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.log_analytics.id
}

output "recovery_vault_id" {
  description = "The ID of the Recovery Vault."
  value       = azurerm_recovery_services_vault.recovery_vault.id
}

output "storage_account_id" {
  description = "The ID of the Storage Account."
  value       = azurerm_storage_account.storage_account.id
}
