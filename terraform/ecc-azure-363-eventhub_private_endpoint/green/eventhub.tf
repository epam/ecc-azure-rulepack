resource "azurerm_eventhub_namespace" "this" {
  name                          = "ehnmspc${var.prefix}green"
  location                      = azurerm_resource_group.this.location
  resource_group_name           = azurerm_resource_group.this.name
  sku                           = "Standard"
  capacity                      = 1
  public_network_access_enabled = false

  tags = var.tags
}

resource "azurerm_eventhub" "this" {
  name                = "eh${var.prefix}green"
  namespace_name      = azurerm_eventhub_namespace.this.name
  resource_group_name = azurerm_resource_group.this.name
  partition_count     = 2
  message_retention   = 1
}