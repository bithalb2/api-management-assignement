terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaterg"
    storage_account_name = "tfstatesurgestg"
    container_name       = "tfstatesurgectr"
    key                  = "terraform.tfstate"
  }
}