resource "azurerm_resource_group" "this" {
  name     = "${module.naming.resource_prefix.resourcegroup}"
  location = "${var.location}"

  tags = module.naming.default_tags
}