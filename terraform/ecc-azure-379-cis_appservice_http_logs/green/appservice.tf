resource "azurerm_app_service_plan" "this" {
  name                = "green-appserviceplan"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "this" {
  name                = "green-app-service"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  app_service_plan_id = azurerm_app_service_plan.this.id
}