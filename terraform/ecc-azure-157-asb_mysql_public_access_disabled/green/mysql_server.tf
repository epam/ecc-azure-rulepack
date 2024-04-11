resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-green"
  location = var.location

  tags = var.tags
}


resource "azurerm_virtual_network" "this" {
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  name                = "vnet-${random_string.this.result}"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet" "this" {
  address_prefixes     = ["10.0.2.0/24"]
  name                 = "subnet-${random_string.this.result}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
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
  name                = "${random_string.this.result}.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = "mysqlfsVnetZone${random_string.this.result}.com"
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  resource_group_name   = azurerm_resource_group.this.name
  virtual_network_id    = azurerm_virtual_network.this.id

  depends_on = [azurerm_subnet.this]
}

resource "azurerm_mysql_flexible_server" "this" {
  name                = "${var.prefix}-mysqlserver-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  administrator_login          = random_string.this.result
  administrator_password       = random_password.this.result
  backup_retention_days        = 7
  delegated_subnet_id          = azurerm_subnet.this.id
  geo_redundant_backup_enabled = false
  private_dns_zone_id          = azurerm_private_dns_zone.this.id
  sku_name                     = "GP_Standard_D2ds_v4"
  version                      = "8.0.21"
  depends_on = [azurerm_private_dns_zone_virtual_network_link.this]
}