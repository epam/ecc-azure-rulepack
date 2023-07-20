resource "azurerm_automation_account" "this" {
  name                = "${var.prefix}autoacc-red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku_name            = "Basic"
  tags                = var.tags
}