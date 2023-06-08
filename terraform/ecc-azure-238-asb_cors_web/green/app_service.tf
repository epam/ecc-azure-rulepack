resource "azurerm_linux_web_app" "this" {
  name                = "app-${var.prefix}-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.this.id
  https_only          = true

  site_config {
    cors {
      allowed_origins = ["google.com"]
    }
  }

  tags = var.tags
}