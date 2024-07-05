resource "azurerm_resource_group" "resources" {
  name     = "RED-INFRASTRUCTURE-CI"
  location = "${var.location}"

  tags = module.naming.default_tags
}