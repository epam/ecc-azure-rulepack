resource "azurerm_management_lock" "lin-lock" {
  name       = "lin-lock"
  scope      = azurerm_linux_virtual_machine.this.id
  lock_level = "CanNotDelete"
  notes      = "Locked because it's needed by policy"

  depends_on = [azurerm_virtual_machine_extension.lin4]

}