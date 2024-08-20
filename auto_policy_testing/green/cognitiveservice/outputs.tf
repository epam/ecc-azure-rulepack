output "cognitiveservice" {
  value = {
    cognitiveservice = azurerm_cognitive_account.this.id,
    ecc-azure-204-asb_cognitive_sa_encrypt_cmk = azurerm_cognitive_account.this1.id
  }
}