resource "azurerm_eventhub_namespace" "this" {
  name                = "EventHubNamespace${var.prefix}Green"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Standard"
  capacity            = 1

  tags = var.tags
}

resource "azurerm_eventhub" "this" {
  name              = "EventHub${var.prefix}Green"
  namespace_id      = azurerm_eventhub_namespace.this.id
  partition_count   = 2
  message_retention = 1
}