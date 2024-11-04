resource "azurerm_virtual_machine_extension" "linuxvm_extension" {
  name                         = "lvmdiagext"
  virtual_machine_id           = azurerm_linux_virtual_machine.linux-vm.id
  publisher                    = "Microsoft.Azure.Diagnostics"
  type                         = "LinuxDiagnostic"
  type_handler_version         = "3.0"

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "winvm_extension" {
  name                         = "wvmdiagext"
  virtual_machine_id           = azurerm_windows_virtual_machine.windows-vm.id
  publisher                    = "Microsoft.Azure.Diagnostics"
  type                         = "IaaSDiagnostics"
  type_handler_version         = "1.1"

  tags = var.tags
}