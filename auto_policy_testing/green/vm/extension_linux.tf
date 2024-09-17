resource "azurerm_virtual_machine_extension" "lin1" {
  name                 = "vm-extensionlingreen"
  virtual_machine_id   = azurerm_linux_virtual_machine.this.id
  publisher            = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                 = "DependencyAgentLinux"
  type_handler_version = "9.10"

  tags = module.naming.default_tags
}

resource "azurerm_virtual_machine_extension" "lin2" {
  name                 = "vm-lin2uxext"
  virtual_machine_id   = azurerm_linux_virtual_machine.this.id
  publisher            = "Microsoft.GuestConfiguration"
  type                 = "ConfigurationForLinux"
  type_handler_version = "1.0"

  tags = module.naming.default_tags

  depends_on = [azurerm_virtual_machine_extension.lin1]
}

resource "azurerm_virtual_machine_extension" "lin3" {
  virtual_machine_id   = azurerm_linux_virtual_machine.this.id
  name                       = "AzureMonitorLinuxAgent"
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = "true"

  depends_on = [azurerm_virtual_machine_extension.lin2]
}

resource "azurerm_virtual_machine_scale_set_extension" "linvmss1" {
  name                         = "lvmssdiagext"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.this.id
  publisher                    = "Microsoft.Azure.Diagnostics"
  type                         = "LinuxDiagnostic"
  type_handler_version         = "3.0"

}

resource "azurerm_virtual_machine_scale_set_extension" "linvmss2" {
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.this1.id
  name                       = "AzureMonitorLinuxAgent"
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = "true"


  depends_on = [azurerm_virtual_machine_scale_set_extension.linvmss1]
}