resource "azurerm_snapshot" "this" {
  name                = "${var.prefix}-snapshot-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  create_option       = "Copy"
  source_uri          = azurerm_managed_disk.this.id
}