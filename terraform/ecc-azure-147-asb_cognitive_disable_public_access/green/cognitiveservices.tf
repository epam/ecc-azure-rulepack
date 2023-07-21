resource "azurerm_cognitive_account" "this" {
  name                = "${var.prefix}-cognitive-acc"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  kind                = "Face"

  public_network_access_enabled = "false"

  sku_name = "F0"

  tags = var.tags
}