output "cognitiveservice" {
  value = {
    cognitiveservice = azurerm_cognitive_account.this.id
  }
}