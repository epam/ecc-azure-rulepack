resource "azurerm_data_protection_backup_vault" "this" {
  name                = "backup${var.prefix}-vault-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  datastore_type      = "VaultStore"
  redundancy          = "GeoRedundant"
  soft_delete         = "Off"
  
  cross_region_restore_enabled = true

  tags                = var.tags
}