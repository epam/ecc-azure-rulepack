resource "azurerm_resource_group" "resources" {
  name     = "GREEN-INFRASTRUCTURE-CI"
  location = "${var.location}"

  tags = module.naming.default_tags
}