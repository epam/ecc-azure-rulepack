resource "azurerm_storage_account" "this" {
  name                     = "sa${var.prefix}green2"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false
  
  default_to_oauth_authentication = true

  provisioner "local-exec" {
    command = "az storage account update --resource-group $resourceGroup --name $resourceName --allow-shared-key-access false"

    environment = {
      resourceGroup = azurerm_resource_group.this.name
      resourceName = azurerm_storage_account.this.name
    }
  }

  tags = var.tags
}

