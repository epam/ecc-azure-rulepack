output "automation" {
  value = {
    automation-account = azurerm_automation_account.this.id
  }
}