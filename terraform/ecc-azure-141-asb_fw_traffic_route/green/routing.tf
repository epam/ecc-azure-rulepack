resource "azurerm_route_table" "this" {
  name                = "rt-${var.prefix}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_route" "Internet" {
  name                = "rt1-${var.prefix}"
  resource_group_name = azurerm_resource_group.this.name
  route_table_name    = azurerm_route_table.this.name
  address_prefix      = "0.0.0.0/0"
  next_hop_type       = "Internet"
}

resource "azurerm_route" "snet1_to_fw" {
  name                   = "rt2-${var.prefix}"
  resource_group_name    = azurerm_resource_group.this.name
  route_table_name       = azurerm_route_table.this.name
  address_prefix         = "10.0.1.0/24"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.fw1.ip_configuration[0].private_ip_address
}

resource "azurerm_route" "snet2_to_fw" {
  name                   = "rt3-${var.prefix}"
  resource_group_name    = azurerm_resource_group.this.name
  route_table_name       = azurerm_route_table.this.name
  address_prefix         = "10.0.2.0/24"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.fw1.ip_configuration[0].private_ip_address
}

resource "azurerm_subnet_route_table_association" "assoc1" {
  subnet_id      = azurerm_subnet.snet1.id
  route_table_id = azurerm_route_table.this.id
}

resource "azurerm_subnet_route_table_association" "assoc2" {
  subnet_id      = azurerm_subnet.snet2.id
  route_table_id = azurerm_route_table.this.id
}

resource "azurerm_subnet_route_table_association" "assoc3" {
  subnet_id      = azurerm_subnet.fwsnet.id
  route_table_id = azurerm_route_table.this.id

  depends_on = [
    azurerm_firewall.fw1,
    azurerm_route.Internet
  ]
}