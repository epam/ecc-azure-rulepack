resource "azurerm_iothub" "this" {
  name                = "iot${var.prefix}green"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  sku {
    name     = "S1"
    capacity = "1"
  }

  tags = var.tags
}

resource "azurerm_iot_security_solution" "this" {
  name                = "${var.prefix}-Iot-Security-Solution"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  display_name        = "Iot Security Solution"
  iothub_ids          = [azurerm_iothub.this.id]
}