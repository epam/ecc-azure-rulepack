resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-red"
  location = var.location

  tags = var.tags
}

resource "azurerm_app_configuration" "appconf" {
  name                = "${var.prefix}appconf-red"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  tags = var.tags
}