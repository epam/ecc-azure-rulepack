resource "azurerm_storage_account" "this" {
  name                     = "${var.prefix}storageaccgreen"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "this" {
  name               = "this-green"
  storage_account_id = azurerm_storage_account.this.id
}

resource "azurerm_synapse_workspace" "this" {
  name                                 = "${var.prefix}-workspace-green"
  resource_group_name                  = azurerm_resource_group.this.name
  location                             = azurerm_resource_group.this.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.this.id
  sql_administrator_login              = random_string.this.result
  sql_administrator_login_password     = random_password.this.result

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}