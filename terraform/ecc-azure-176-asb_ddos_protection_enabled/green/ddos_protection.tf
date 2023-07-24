resource "azurerm_network_ddos_protection_plan" "this" {
  name                = "${var.prefix}-ddos_prot_plan"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = var.tags
}