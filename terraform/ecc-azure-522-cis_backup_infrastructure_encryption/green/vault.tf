resource "null_resource" "backup_encryption" {
  provisioner "local-exec" {
    command = "az dataprotection backup-vault create --resource-group $resourceGroup --vault-name $vaultName --location 'eastus' --storage-setting $storageSetting --type 'UserAssigned' --mi-user-assigned $identityId --cmk-encryption-key-uri $keyUri --cmk-encryption-state Enabled --cmk-identity-type 'UserAssigned' --cmk-user-assigned-identity-id $identityId --cmk-infrastructure-encryption Enabled"
    environment = {
      resourceGroup = azurerm_resource_group.this.name
      vaultName = "backup${var.prefix}-vault-green"
      identityId = azurerm_user_assigned_identity.this.id
      keyUri = azurerm_key_vault_key.this.id
      storageSetting = "[{type:'LocallyRedundant',datastore-type:'VaultStore'}]"
    }
  }

  depends_on = [ azurerm_key_vault_access_policy.backupvault, azurerm_key_vault_access_policy.client, azurerm_user_assigned_identity.this, azurerm_key_vault_key.this ]
}