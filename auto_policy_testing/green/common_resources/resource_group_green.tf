resource "azurerm_resource_group" "resources" {
  name     = "${GREEN-INFRASTRUCTURE-CI}1"
  location = "${var.location}"

  tags = module.naming.default_tags
}