resource "azurerm_virtual_network" "this" {
  name                = "${var.prefix}-network-red"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  
  tags = var.tags
}

resource "azurerm_subnet" "this" {
  name                 = "${var.prefix}internal-red"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nif1" {
  name                = "${var.prefix}-first-red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}