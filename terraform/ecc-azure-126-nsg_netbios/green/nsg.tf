resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-green"
  location = var.location
}

resource "azurerm_network_security_group" "this" {
  name                = "${var.prefix}-nsg-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  security_rule {
    name                       = "${var.prefix}-rule-green"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "139"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}