resource "azurerm_disk_encryption_set" "this" {
  name                = "${var.prefix}1-diskencr-green"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  key_vault_key_id    = azurerm_key_vault_key.key.id

  identity {
    type = "SystemAssigned"
  }
}