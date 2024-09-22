resource "azurerm_private_endpoint" "this" {
  name                = module.naming.resource_prefix.privateendpoint
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  subnet_id           = data.terraform_remote_state.common.outputs.subnet_id

  private_service_connection {
    name                           = "connection_mlw_green"
    private_connection_resource_id = azurerm_machine_learning_workspace.this.id
    subresource_names              = ["amlworkspace"]
    is_manual_connection           = false
  }

  tags = module.naming.default_tags

  depends_on = [
    azurerm_machine_learning_workspace.this
  ]

  timeouts {
    create = "2h"
    delete = "2h"
  }
}
