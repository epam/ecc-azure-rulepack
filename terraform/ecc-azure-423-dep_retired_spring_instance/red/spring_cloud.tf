resource "azurerm_application_insights" "this" {
  name                = "appinsights${var.prefix}red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  application_type    = "web"
}

resource "azurerm_spring_cloud_service" "this" {
  name                = "sprcld${var.prefix}-red"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku_name            = "S0"

  tags = var.tags
}