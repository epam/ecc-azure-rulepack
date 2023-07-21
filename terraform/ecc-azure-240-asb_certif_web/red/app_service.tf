resource "azurerm_linux_web_app" "this" {
  name                       = "app-${var.prefix}-red"
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  service_plan_id            = azurerm_service_plan.this.id
  client_certificate_enabled = false
  https_only                 = true

  site_config {}

  tags = var.tags
}