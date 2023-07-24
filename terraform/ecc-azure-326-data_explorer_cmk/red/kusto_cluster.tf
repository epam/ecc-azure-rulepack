resource "azurerm_kusto_cluster" "this" {
  name                = "ks${var.prefix}red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  sku {
    name     = "Standard_D13_v2"
    capacity = 2
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}