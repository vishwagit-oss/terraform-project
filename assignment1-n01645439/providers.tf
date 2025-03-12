terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.10" # Ensure a version >= 3.10 is used
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "f09fc06e-e708-45c7-bcd9-ab4fa4d2528a"
}
