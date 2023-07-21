resource "azurerm_cognitive_account" "this" {
  name                = "${var.prefix}-account-red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  kind                = "CustomVision.Training"
  sku_name            = "F0"

  tags = var.tags
}