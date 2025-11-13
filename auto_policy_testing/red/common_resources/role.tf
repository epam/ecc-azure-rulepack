resource "azurerm_role_assignment" "this" {
  scope                = azurerm_resource_group.resources.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}