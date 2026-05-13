provider "azurerm" {
  features {}
}

# Hub subscription
provider "azurerm" {
  alias           = "hub"
  subscription_id = var.hub_subscription_id
  features {}
}