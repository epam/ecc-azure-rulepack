output "keyvault" {
  value = {
    keyvault        = azurerm_key_vault.this.id,
    keyvault-key    = azurerm_key_vault_key.this.versionless_id,
    keyvault-secret = azurerm_key_vault_secret.this.versionless_id,
    ecc-azure-170-asb_keyvault_private_endpoint = azurerm_key_vault.this1.id
  }
}