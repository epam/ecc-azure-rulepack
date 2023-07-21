resource "azurerm_virtual_machine_extension" "this" {
  name                 = "${var.prefix}extensiongreen"
  virtual_machine_id   = azurerm_windows_virtual_machine.this.id
  publisher            = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                 = "DependencyAgentWindows"
  type_handler_version = "9.5"

  tags = var.tags
}