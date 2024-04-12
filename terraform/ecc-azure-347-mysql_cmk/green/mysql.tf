resource "azurerm_user_assigned_identity" "this" {
  location            = azurerm_resource_group.this.location
  name                = random_string.this.result
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_mysql_flexible_server" "this" {
  name                = "${var.prefix}-mysqlserver-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  administrator_login          = random_string.this.result
  administrator_password       = random_password.this.result
  sku_name                     = "GP_Standard_D2ds_v4"

  identity {
    type = "UserAssigned"
    identity_ids = [ azurerm_user_assigned_identity.this.id ]
  }
  
  customer_managed_key {
    key_vault_key_id = azurerm_key_vault_key.this.id
    primary_user_assigned_identity_id = azurerm_user_assigned_identity.this.id
  }
}