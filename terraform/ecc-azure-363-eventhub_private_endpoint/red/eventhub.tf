resource "azurerm_eventhub_namespace" "this" {
  name                = "ehnmspc${var.prefix}red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Standard"
  capacity            = 1

  tags = var.tags
}

resource "azurerm_eventhub" "this" {
  name                = "eh${var.prefix}red"
  namespace_name      = azurerm_eventhub_namespace.this.name
  resource_group_name = azurerm_resource_group.this.name
  partition_count     = 2
  message_retention   = 1
}