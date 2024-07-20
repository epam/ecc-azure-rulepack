resource "azurerm_virtual_network" "this" {
  name                = module.naming.resource_prefix.vnet
  address_space       = ["10.0.0.0/16"]
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  
  tags                 = module.naming.default_tags
}

resource "azurerm_subnet" "this" {
  name                 = module.naming.resource_prefix.subnet
  resource_group_name  = data.terraform_remote_state.common.outputs.resource_group
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "fs"

    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_private_dns_zone" "this" {
  name                = "mysqlgreen${random_integer.this.result}.mysql.database.azure.com"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = "mysqlfsVnetZonemysqlgreen${random_string.this.result}.com"
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  resource_group_name   = data.terraform_remote_state.common.outputs.resource_group
  virtual_network_id    = azurerm_virtual_network.this.id

  depends_on = [azurerm_subnet.this]
}