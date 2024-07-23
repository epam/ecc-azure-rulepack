resource "azurerm_mssql_managed_instance" "this" {
  name                          = module.naming.resource_prefix.sql-managed-instance
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group

  license_type       = "BasePrice"
  sku_name           = "GP_Gen5"
  storage_size_in_gb = 32
  subnet_id          = azurerm_subnet.this.id
  vcores             = 4

  administrator_login          = random_string.this.result
  administrator_login_password = random_password.this.result

  tags = module.naming.default_tags

  depends_on = [
    azurerm_subnet_network_security_group_association.this,
    azurerm_subnet_route_table_association.this,
  ]
}