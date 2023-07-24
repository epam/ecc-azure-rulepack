resource "azurerm_virtual_network" "this" {
  name                = "${var.prefix}vnet_green"
  address_space       = ["10.0.0.0/24"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = var.tags
}

resource "azurerm_subnet" "this" {
  name                                           = "snet${var.prefix}green"
  resource_group_name                            = azurerm_resource_group.this.name
  virtual_network_name                           = azurerm_virtual_network.this.name
  address_prefixes                               = ["10.0.0.0/26"]
  enforce_private_link_endpoint_network_policies = true
}


resource "azurerm_private_endpoint" "this" {
  name                = "${var.prefix}endpgreen"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = azurerm_subnet.this.id

  private_service_connection {
    name                           = "connection_green"
    private_connection_resource_id = azurerm_eventgrid_topic.this.id
    subresource_names              = ["topic"]
    is_manual_connection           = false
  }

  depends_on = [
    azurerm_eventgrid_topic.this,
    azurerm_virtual_network.this,
    azurerm_subnet.this
  ]
}
