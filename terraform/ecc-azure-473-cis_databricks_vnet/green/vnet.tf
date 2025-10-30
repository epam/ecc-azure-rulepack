resource "azurerm_virtual_network" "this" {
  name                = "vnet-${var.prefix}"
  address_space       = ["10.0.0.0/24"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  tags = var.tags
}

resource "azurerm_subnet" "this" {
  name                 = "snet1-${var.prefix}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.0.0/25"]
  delegation {
    name = "databricksDelegation"
    service_delegation {
        name = "Microsoft.Databricks/workspaces"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
  }
}

resource "azurerm_subnet" "this1" {
  name                 = "snet2-${var.prefix}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.0.128/25"]
  delegation {
    name = "databricksDelegation"
    service_delegation {
        name = "Microsoft.Databricks/workspaces"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
  }
}

resource "azurerm_network_security_group" "this" {
  name                = "nsg1-${var.prefix}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_subnet_network_security_group_association" "this1" {
  subnet_id                 = azurerm_subnet.this1.id
  network_security_group_id = azurerm_network_security_group.this.id
}