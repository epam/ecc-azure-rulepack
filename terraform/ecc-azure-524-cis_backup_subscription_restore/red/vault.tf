resource "azurerm_data_protection_backup_vault" "this" {
  name                = "backup${var.prefix}-vault-red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  datastore_type      = "VaultStore"
  redundancy          = "LocallyRedundant"
  soft_delete         = "Off"

  provisioner "local-exec" {
    command = "az dataprotection backup-vault update --resource-group $resourceGroup --vault-name $resourceName --cross-subscription-restore-state Enabled"

    environment = {
      resourceGroup = azurerm_resource_group.this.name
      resourceName = "backup${var.prefix}-vault-red"
    }
  }

  tags                = var.tags
}