resource "azurerm_resource_group" "this" {
  name     = "${module.naming.resource_prefix.resourcegroup}1"
  location = "${var.location}"

  tags = module.naming.default_tags
}