resource "azurerm_kusto_cluster" "this" {
  name                = "ks${var.prefix}green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  sku {
    name     = "Dev(No SLA)_Standard_D11_v2"
    capacity = 1
  }

  identity {
    type = "SystemAssigned"
  }

  disk_encryption_enabled = true

  tags = var.tags
}