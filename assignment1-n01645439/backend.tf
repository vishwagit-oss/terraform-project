terraform {
  backend "azurerm" {
    resource_group_name   = "terraform-backend-rg"
    storage_account_name  = "5439tfstateaccount001"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}
