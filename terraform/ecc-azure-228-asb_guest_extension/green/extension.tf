resource "azurerm_virtual_machine_extension" "linuxvm_extension" {
  name                 = "${var.prefix}linuxext"
  virtual_machine_id   = azurerm_linux_virtual_machine.linuxvm.id
  publisher            = "Microsoft.GuestConfiguration"
  type                 = "ConfigurationForLinux"
  type_handler_version = "1.0"

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "winvm_extension" {
  name                 = "${var.prefix}winext"
  virtual_machine_id   = azurerm_windows_virtual_machine.winvm.id
  publisher            = "Microsoft.GuestConfiguration"
  type                 = "ConfigurationforWindows"
  type_handler_version = "1.11"

  tags = var.tags
}