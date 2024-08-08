resource "azurerm_private_endpoint" "this" {
  name                          = module.naming.resource_prefix.privateendpoint
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  subnet_id                     = data.terraform_remote_state.common.outputs.subnet_id

  private_service_connection {
    name                           = "connection_green"
    private_connection_resource_id = azurerm_key_vault.this.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  depends_on = [
    azurerm_key_vault.this
  ]
}