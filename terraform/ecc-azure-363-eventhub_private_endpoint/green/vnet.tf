resource "azurerm_virtual_network" "this" {
  name                = "vnet${var.prefix}-green"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  tags = var.tags
}

resource "azurerm_subnet" "this" {
  name                 = "snet${var.prefix}green"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_private_endpoint" "this" {
  name                = "prvendp${var.prefix}green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = azurerm_subnet.this.id

  private_service_connection {
    name                           = "prvcon${var.prefix}green"
    private_connection_resource_id = azurerm_eventhub_namespace.this.id
    is_manual_connection           = true
    subresource_names              = ["namespace"]
    request_message                = "PL"
  }
}