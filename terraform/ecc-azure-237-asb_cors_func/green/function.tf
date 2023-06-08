resource "azurerm_linux_function_app" "this" {
  name                       = "functions${var.prefix}-green"
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  service_plan_id            = azurerm_service_plan.this.id
  storage_account_name       = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key

  site_config {
    cors {
      allowed_origins = ["google.com"]
    }
  }

  tags = var.tags
}