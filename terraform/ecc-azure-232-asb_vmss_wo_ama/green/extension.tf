resource "azurerm_virtual_machine_scale_set_extension" "ext1" {
  virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.vmsswin1.id
  name                       = "AzureMonitorWindowsAgent"
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorWindowsAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = "true"
}

resource "azurerm_virtual_machine_scale_set_extension" "ext2" {
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.vmsslin2.id
  name                       = "AzureMonitorLinuxAgent"
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = "true"
}