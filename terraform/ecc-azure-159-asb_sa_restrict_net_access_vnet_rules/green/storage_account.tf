resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-green"
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet${var.prefix}green"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}
resource "azurerm_subnet" "this" {
  name                 = "snet${var.prefix}green"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
}
resource "azurerm_public_ip" "this" {
  name                = "${var.prefix}pip_green"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  allocation_method   = "Static"

  tags = var.tags
}

resource "azurerm_storage_account" "this" {
  name                = "${var.prefix}storageaccgreen"
  resource_group_name = azurerm_resource_group.this.name

  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Deny"
    ip_rules                   = [azurerm_public_ip.this.ip_address]
    virtual_network_subnet_ids = [azurerm_subnet.this.id]
  }

  tags = var.tags
}