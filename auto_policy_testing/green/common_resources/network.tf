resource "azurerm_virtual_network" "this" {
  name                = "vnet${random_integer.this.result}green"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}
resource "azurerm_subnet" "this" {
  name                 = "snet${random_integer.this.result}green"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
}
resource "azurerm_public_ip" "this" {
  name                = "${random_integer.this.result}pip_green"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  allocation_method   = "Static"
  sku = "Standard"

  tags = var.tags
}