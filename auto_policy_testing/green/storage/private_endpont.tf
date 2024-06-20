resource "azurerm_private_endpoint" "this" {
  name                = "${random_string.this.result}endpgreen"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = data.terraform_remote_state.common.outputs.subnet_id

  private_service_connection {
    name                           = "connection_green"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  depends_on = [
    azurerm_storage_account.this
  ]
}