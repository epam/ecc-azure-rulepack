output "keyvault" {
  value = {
    keyvault = azurerm_key_vault.this.id
    keyvault-key = azurerm_key_vault_key.this.id
  }
}