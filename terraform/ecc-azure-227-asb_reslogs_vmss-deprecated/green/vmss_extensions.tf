resource "azurerm_virtual_machine_scale_set_extension" "linux_ext" {
  name                         = "lvmssdiagext"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.this.id
  publisher                    = "Microsoft.Azure.Diagnostics"
  type                         = "LinuxDiagnostic"
  type_handler_version         = "3.0"
}

resource "azurerm_virtual_machine_scale_set_extension" "win_ext" {
  name                         = "wvmssdiagext"
  virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.this.id
  publisher                    = "Microsoft.Azure.Diagnostics"
  type                         = "IaaSDiagnostics"
  type_handler_version         = "1.1"
}