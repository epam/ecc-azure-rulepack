resource "azurerm_virtual_machine_extension" "AzureMonitorLinuxAgent" {        
  name                       = "AzureMonitorLinuxAgent"
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = "true"
    
  virtual_machine_id = azurerm_linux_virtual_machine.vm1.id
}

resource "azurerm_virtual_machine_extension" "AzureMonitorWindowsAgent" {        
  name                       = "AzureMonitorWindowsAgent"
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorWindowsAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = "true"
    
  virtual_machine_id = azurerm_windows_virtual_machine.vm2.id
}