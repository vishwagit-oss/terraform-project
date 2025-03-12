resource "azurerm_resource_group" "rgroup" {
  name     = "5439-RG"
  location = var.location

  tags = var.tags
}
