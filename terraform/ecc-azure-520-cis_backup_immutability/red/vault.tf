resource "azurerm_data_protection_backup_vault" "this" {
  name                = "backup${var.prefix}-vault-red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  datastore_type      = "VaultStore"
  redundancy          = "LocallyRedundant"
  soft_delete         = "Off"

  immutability        = "Disabled"

  tags                = var.tags
}