resource "azurerm_service_plan" "this" {
  name                = "sp-${var.prefix}-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Linux"
  sku_name            = "B1"

  tags = var.tags
}

resource "azurerm_linux_web_app" "this" {
  name                = "app-${var.prefix}-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.this.id
  https_only          = true

  site_config {
    application_stack {
      python_version = "3.11"
    }
  }

  tags = var.tags
}