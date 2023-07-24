resource "azurerm_eventhub_namespace" "this" {
  name                = "eh${var.prefix}tstgreen"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Basic"
  capacity            = 1

  tags = var.tags
}

resource "azurerm_eventhub" "this" {
  name                = "eh${var.prefix}tstgreen"
  namespace_name      = azurerm_eventhub_namespace.this.name
  resource_group_name = azurerm_resource_group.this.name
  partition_count     = 2
  message_retention   = 1
}