resource "azurerm_resource_group" "app_group" {
  name     = var.resource_group_name
  location = var.region_name
  tags     = data.azurerm_resource_group.backend_resource_group_name.tags
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = var.log_analytics_workspace_name
  resource_group_name = azurerm_resource_group.app_group.name
  location            = azurerm_resource_group.app_group.location
  sku                 = "PerGB2018"
  retention_in_days   = 90
  tags                = data.azurerm_resource_group.backend_resource_group_name.tags
}
