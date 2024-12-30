## Resource Group creation
resource "azurerm_resource_group" "SurgeAssignmentRG" {
  name     = "SurgeAssignmentRG"
  location = "Central India"
}

## API Management creation
resource "azurerm_api_management" "SurgeAssignmentAPIM" {
  name                = "SurgeAssignmentAPIM"
  resource_group_name = azurerm_resource_group.SurgeAssignmentRG.name
  location            = azurerm_resource_group.SurgeAssignmentRG.location
  publisher_name      = "Subhra JENA"
  publisher_email     = "jsubhra94@gmail.com"

  sku_name = "Developer_1"
}

## An API creation within API Management
resource "azurerm_api_management_api" "SurgeAssignmentAPIMAPI" {
  name                = "SurgeAssignmentAPIMAPI"
  api_management_name = azurerm_api_management.SurgeAssignmentAPIM.name
  resource_group_name = azurerm_resource_group.SurgeAssignmentRG.name
  revision            = "1"
  display_name        = "SurgeAssignmentAPI"
  path                = ""
  protocols           = ["https"]
  service_url         = ""

  import {
    content_format = "swagger-lin-json"
    content_value  = ""
  }
}