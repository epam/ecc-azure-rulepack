resource "azurerm_postgresql_flexible_server" "this" {
  name                          = "${var.prefix}postgresqlserver-green"
  location                      = azurerm_resource_group.this.location
  resource_group_name           = azurerm_resource_group.this.name
  version                       = "12"
  public_network_access_enabled = false
  administrator_login           = random_string.this.result
  administrator_password        = random_password.this.result

  storage_mb   = 32768
  storage_tier = "P30"

  sku_name   = "GP_Standard_D4s_v3"

  tags = var.tags
}