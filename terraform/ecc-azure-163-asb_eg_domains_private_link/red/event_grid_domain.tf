resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-red"
  location = var.location

  tags = var.tags
}

resource "azurerm_eventgrid_domain" "this" {
  name                = "eg-${var.prefix}-red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  tags = var.tags
}