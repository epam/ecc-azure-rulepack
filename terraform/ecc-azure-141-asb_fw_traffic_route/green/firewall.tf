resource "azurerm_public_ip" "pip1" {
  name                = "pip1-${var.prefix}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "fw1" {
  name                = "fw-${var.prefix}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku_tier            = "Standard"
  sku_name            = "AZFW_VNet"

  ip_configuration {
    name                 = "config1-${var.prefix}"
    subnet_id            = azurerm_subnet.fwsnet.id
    public_ip_address_id = azurerm_public_ip.pip1.id
  }
}