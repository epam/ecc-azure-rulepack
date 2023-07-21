resource "azurerm_disk_encryption_set" "this" {
  name                = "${var.prefix}encrset-red"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  key_vault_key_id    = azurerm_key_vault_key.this.id

  identity {
    type = "SystemAssigned"
  }
}