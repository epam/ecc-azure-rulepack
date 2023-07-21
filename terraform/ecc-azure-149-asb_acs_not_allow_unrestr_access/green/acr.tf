resource "azurerm_container_registry" "this" {
  name                          = "${var.prefix}acrgreen"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = azurerm_resource_group.this.location
  sku                           = "Premium"
  admin_enabled                 = false
  public_network_access_enabled = false
  network_rule_set {
    default_action = "Deny"
  }

  tags = var.tags
}