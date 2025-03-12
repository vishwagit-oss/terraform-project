resource "azurerm_resource_group" "rgroup" {
  name     = "5439-RG"
  location = var.location

  tags = {
    Assignment    = "CCGC 5502 Automation Assignment"
    Name          = "firstname.lastname"
    ExpirationDate = "2024-12-31"
    Environment   = "Learning"
  }
}
