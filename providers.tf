provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name = "tfstateRG"
    storage_account_name = "tfstateSTG"
    container_name = "tfstateCTR"
    key = "terraform.tfstate"
  }
}