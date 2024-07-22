resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-red"
  location = var.location

  tags = var.tags
}

resource "azurerm_mysql_flexible_server" "this" {
  name                          = "mysqlserver${var.prefix}-red"
  location                      = azurerm_resource_group.this.location
  resource_group_name           = azurerm_resource_group.this.name

  administrator_login           = random_string.this.result
  administrator_password        = random_password.this.result
  sku_name                      = "GP_Standard_D2ds_v4"

  geo_redundant_backup_enabled = false

  tags = var.tags
}