output "role" {
  value = {
    roledefinition = azurerm_role_definition.this.id
  }
}