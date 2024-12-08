resource "azurerm_service_plan" "this" {
  name                = "sp-${var.prefix}-red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Linux"
  sku_name            = "B1"
  app_service_environment_id = azurerm_app_service_environment_v3.this.id

  tags = var.tags
}

resource "azurerm_virtual_network" "this" {
  name                = "${var.prefix}-red-vnet"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "this" {
  name                 = "${var.prefix}-red-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.2.0/24"]

  delegation {
    name = "Microsoft.Web.hostingEnvironments"
    service_delegation {
      name    = "Microsoft.Web/hostingEnvironments"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_app_service_environment_v3" "this" {
  name                = "${var.prefix}-red-asev3"
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = azurerm_subnet.this.id

  tags = var.tags
}
