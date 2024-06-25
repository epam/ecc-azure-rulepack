resource "azurerm_storage_account" "this" {
  name                     = "sa${random_integer.this.result}green"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}