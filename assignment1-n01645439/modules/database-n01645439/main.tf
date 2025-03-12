resource "azurerm_postgresql_server" "db_server" {
  name                         = var.db_server_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  sku_name                     = "B_Gen5_1" # Basic SKU, 1 vCore
  version                      = "11"       # PostgreSQL version
  administrator_login          = var.db_admin_username
  administrator_login_password = var.db_admin_password
  storage_mb                   = 5120 # 5 GB of storage
  backup_retention_days        = 7    # Backup retention
  ssl_enforcement_enabled      = true

  tags = var.tags
}

resource "azurerm_postgresql_database" "db" {
  name                = var.db_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.db_server.name
  charset             = "UTF8"
  collation           = "en_US.utf8"
}
