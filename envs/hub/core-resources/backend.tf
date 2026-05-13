terraform {
  backend "azurerm" {
    resource_group_name  = "bktfstorageRG"
    storage_account_name = "asstgtfstate"
    container_name       = "tfstate"
    key                  = "network-hub.tfstate"
  }
}