resource "azurerm_storage_account" "this" {
  name                     = "sa${var.prefix}green"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags                     = var.tags


  #secondary_location       = {value} - not possible to deploy with this setting. this will be set automaticaly by Terraform
}