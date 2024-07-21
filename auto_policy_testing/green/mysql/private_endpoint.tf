resource "azurerm_private_endpoint" "this" {
  name                          = "mysqlendpgreen${random_integer.this.result}"
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  subnet_id                     = data.terraform_remote_state.common.outputs.subnet_id

  private_service_connection {
    name                           = "connection_green"
    private_connection_resource_id = azurerm_mysql_flexible_server.this.id
    subresource_names              = ["mysqlServer"]
    is_manual_connection           = false
  }

  depends_on = [
    azurerm_mysql_flexible_server.this
  ]
}