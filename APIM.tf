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

## API Management backend creation
resource "azurerm_api_management_backend" "SurgeAssignmentBKEND" {
  name                = "SurgeAssignmentBKEND"
  resource_group_name = azurerm_resource_group.SurgeAssignmentRG.name
  api_management_name = azurerm_api_management.SurgeAssignmentAPIM.name
  protocol            = "http"
  url                 = "https://${azurerm_linux_function_app.SurgeAssignmentFNAPP.name}.azurewebsites.net/api/"

  credentials {
    header = {
      "x-functions-key" = "${data.azurerm_function_app_host_keys.SurgeAssignmentHSTKY.default_function_key}"
    }
  }
}

## An API creation within API Management
resource "azurerm_api_management_api" "SurgeAssignmentAPIMAPI" {
  name                = "SurgeAssignmentAPIMAPI"
  api_management_name = azurerm_api_management.SurgeAssignmentAPIM.name
  resource_group_name = azurerm_resource_group.SurgeAssignmentRG.name
  revision            = "1"
  display_name        = "Surge Assignment API"
  path                = ""
  protocols           = ["https"]

  import {
    content_format = "openapi"
    content_value  = file("${path.module}/FuncOpenAPI.yml")
  }
}