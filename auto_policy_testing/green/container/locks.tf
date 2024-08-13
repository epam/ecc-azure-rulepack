resource "azurerm_management_lock" "lin-lock" {
  name       = "cont-lock"
  scope      = azurerm_container_registry.this.id
  lock_level = "CanNotDelete"
  notes      = "Locked because it's needed by policy"

  depends_on = [azurerm_private_endpoint.this]

}