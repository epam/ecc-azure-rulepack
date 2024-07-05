resource "azurerm_resource_group" "this" {
  name     = module.naming.resource_prefix.resourcegroup
  location = "${var.location}"
}