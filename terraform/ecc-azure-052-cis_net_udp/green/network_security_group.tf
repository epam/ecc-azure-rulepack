resource "azurerm_network_security_group" "this" {
  name                = "${var.prefix}-nsg-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  security_rule {
    name                       = "deny_inbound_udp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

