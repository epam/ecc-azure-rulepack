resource "azurerm_data_factory" "this" {
  name                = "kusto${var.prefix}red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  tags = var.tags
}