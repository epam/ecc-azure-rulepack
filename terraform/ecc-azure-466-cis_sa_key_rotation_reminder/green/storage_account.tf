resource "azurerm_storage_account" "this" {
  name                     = "sa${var.prefix}green"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false

  provisioner "local-exec" {
    command = "az storage account update --name $storageName --resource-group $resourceGroup --key-exp-days 90"

    environment = {
      resourceGroup = azurerm_resource_group.this.name
      storageName = azurerm_storage_account.this.name
    }
  }

  tags = var.tags
}