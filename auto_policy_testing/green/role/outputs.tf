output "role" {
  value = {
    roledefinition = azurerm_role_definition.this.role_definition_resource_id
  }
}