output "keyvault" {
  value = {
    keyvault        = azurerm_key_vault.this.id,
    keyvault-key    = azurerm_key_vault_key.this.resource_id,
    keyvault-secret = azurerm_key_vault_secret.this.resource_id
  }
}