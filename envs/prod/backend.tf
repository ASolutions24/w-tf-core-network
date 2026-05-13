terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tf-prod-sf"
    storage_account_name = "stgtfprodstatefile"
    container_name       = "tfstate"
    key                  = "network-prod.tfstate"
  }
}