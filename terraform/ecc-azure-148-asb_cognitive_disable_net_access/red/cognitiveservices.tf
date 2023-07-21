resource "azurerm_cognitive_account" "this" {
  name                = "ca${var.prefix}red-${random_integer.ri.result}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  kind                = "Face"

  sku_name = "F0"

  custom_subdomain_name = "dntest${random_integer.ri.result}"

  network_acls {
    default_action = "Allow"
  }

  tags = var.tags
}