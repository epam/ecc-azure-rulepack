resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-red"
  location = var.location
  tags     = var.tags
}

resource "azurerm_container_registry" "this" {
  name                = "acr${var.prefix}red"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Standard"

  anonymous_pull_enabled = true

  tags = var.tags
}