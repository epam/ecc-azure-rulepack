resource "azurerm_service_plan" "this" {
  name                = "sp-${var.prefix}-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Linux"
  sku_name            = "P1v2"

  tags = var.tags
}

resource "azurerm_linux_web_app" "this" {
  name                = "app-${var.prefix}-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.this.id

  site_config {}

  identity {
    type = "UserAssigned"
    identity_ids = [ azurerm_user_assigned_identity.this.id ]
  }

  key_vault_reference_identity_id = azurerm_user_assigned_identity.this.id
  tags = var.tags
}