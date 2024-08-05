resource "azurerm_private_endpoint" "this" {
  name                = module.naming.resource_prefix.privateendpoint
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  subnet_id           = data.terraform_remote_state.common.outputs.subnet_idd

  private_service_connection {
    name                           = "connection_signalr_green"
    private_connection_resource_id = azurerm_signalr_service.this.id
    subresource_names              = ["signalr"]
    is_manual_connection           = false
  }

  tags = module.naming.default_tags

  depends_on = [
    azurerm_signalr_service.this
  ]
}