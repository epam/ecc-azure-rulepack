resource "azurerm_machine_learning_workspace" "this" {
  name                    = "mlwsp${var.prefix}green1"
  location                = azurerm_resource_group.this.location
  resource_group_name     = azurerm_resource_group.this.name
  application_insights_id = azurerm_application_insights.this.id
  key_vault_id            = azurerm_key_vault.this.id
  storage_account_id      = azurerm_storage_account.this.id

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_management_lock" "this" {
  name       = "nsg${var.prefix}greenlock"
  scope      = azurerm_machine_learning_workspace.this.id
  lock_level = "ReadOnly"
  notes      = "This ML can't be edited!"
}