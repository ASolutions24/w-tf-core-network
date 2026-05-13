provider "azurerm" {
  features {}
}

# Hub subscription
provider "azurerm" {
  alias           = "hub"
  subscription_id = var.hub_subscription_id
  features {}
}

# Spoke subscription (optional if same as default)
provider "azurerm" {
  alias           = "spoke"
  subscription_id = var.spoke_subscription_id
  features {}
}