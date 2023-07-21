resource "azurerm_container_registry" "acr1" {
  name                          = "${var.prefix}acr1red"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = azurerm_resource_group.this.location
  sku                           = "Premium"
  admin_enabled                 = false
  public_network_access_enabled = true
  network_rule_set {
    default_action = "Allow"
  }

  tags = var.tags
}

resource "azurerm_container_registry" "acr2" {
  name                = "${var.prefix}acr2red"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Basic"
  admin_enabled       = false
  tags                = var.tags
}