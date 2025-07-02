resource "azurerm_network_security_group" "this" {
  name                = "${var.prefix}-nsg-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  tags = var.tags
}

resource "azurerm_management_lock" "this" {
  name       = "nsg${var.prefix}greenlock"
  scope      = azurerm_network_security_group.this.id
  lock_level = "ReadOnly"
  notes      = "This NSG can't be edited!"
}


