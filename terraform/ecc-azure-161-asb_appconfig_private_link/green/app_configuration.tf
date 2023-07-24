resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-green"
  location = var.location

  tags = var.tags
}

resource "azurerm_app_configuration" "this" {
  name                = "${var.prefix}appconf-green"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "standard"

  tags = var.tags
}