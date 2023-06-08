data "azurerm_client_config" "current" {}

resource "azurerm_storage_account" "this" {
  name                     = "${var.prefix}sagreen"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_storage_account_customer_managed_key" "this" {
  storage_account_id = azurerm_storage_account.this.id
  key_vault_id       = azurerm_key_vault.this.id
  key_name           = azurerm_key_vault_key.this.name
}