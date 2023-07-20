resource "azurerm_kusto_cluster" "this" {
  name                = "ks${var.prefix}green"
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

resource "azurerm_kusto_cluster_customer_managed_key" "this" {
  cluster_id   = azurerm_kusto_cluster.this.id
  key_vault_id = azurerm_key_vault.this.id
  key_name     = azurerm_key_vault_key.this.name
  key_version  = azurerm_key_vault_key.this.version
}