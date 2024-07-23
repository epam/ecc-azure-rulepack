resource "azurerm_mssql_managed_instance" "this" {
  name                = "${var.prefix}-sqlmanaged-green"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  license_type       = "BasePrice"
  sku_name           = "GP_Gen5"
  storage_size_in_gb = 32
  subnet_id          = azurerm_subnet.this.id
  vcores             = 4

  administrator_login          = random_string.this.result
  administrator_login_password = random_password.this.result

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags

  depends_on = [
    azurerm_subnet_network_security_group_association.this,
    azurerm_subnet_route_table_association.this
  ]
}

resource "azurerm_mssql_managed_instance_transparent_data_encryption" "this" {
  managed_instance_id = azurerm_mssql_managed_instance.this.id
  key_vault_key_id    = azurerm_key_vault_key.this.id
}