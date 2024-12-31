## Storage Account creation for Azure Functions App
resource "azurerm_storage_account" "surgeassignmentstg" {
  name                     = "surgeassignmentstg"
  location                 = azurerm_resource_group.SurgeAssignmentRG.location
  resource_group_name      = azurerm_resource_group.SurgeAssignmentRG.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

## Service Plan creation for Azure Functions App
resource "azurerm_service_plan" "SurgeAssignmentSPLAN" {
  name                = "SurgeAssignmentSPLAN"
  location            = azurerm_resource_group.SurgeAssignmentRG.location
  resource_group_name = azurerm_resource_group.SurgeAssignmentRG.name
  os_type             = "Linux"
  sku_name            = "Y1"
}

## Functions App creation
resource "azurerm_linux_function_app" "SurgeAssignmentFNAPP" {
  name                       = "SurgeAssignmentFNAPP"
  location                   = azurerm_resource_group.SurgeAssignmentRG.location
  resource_group_name        = azurerm_resource_group.SurgeAssignmentRG.name
  storage_account_name       = azurerm_storage_account.surgeassignmentstg.name
  storage_account_access_key = azurerm_storage_account.surgeassignmentstg.id
  service_plan_id            = azurerm_service_plan.SurgeAssignmentSPLAN.id
  site_config {

  }
}

## Functions App host key
data "azurerm_function_app_host_keys" "SurgeAssignmentHSTKY" {
  name                = "SurgeAssignmentHSTKY"
  resource_group_name = azurerm_resource_group.SurgeAssignmentRG.name
}