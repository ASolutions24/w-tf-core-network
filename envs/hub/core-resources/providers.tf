/*
provider "azurerm" {
  features {}
  subscription_id = "1cec5258-8248-4460-80f9-0731a12caadf"
}

provider "azurerm" {
  alias           = "hub"
  features        {}
  subscription_id = "39aca73e-1d25-4edf-84d5-ebe0397a816b"
}
*/

provider "azurerm" {
  features {}
}

# Hub subscription
provider "azurerm" {
  alias           = "hub"
  subscription_id = var.hub_subscription_id
  features {}
}
/*
# Spoke subscription (optional if same as default)
provider "azurerm" {
  alias           = "spoke"
  subscription_id = var.spoke_subscription_id
  features {}
}
*/