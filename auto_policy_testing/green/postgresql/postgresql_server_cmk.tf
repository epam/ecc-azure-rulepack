resource "azurerm_postgresql_server" "cmk" {
  name                = "${module.naming.resource_prefix.postgresql-server}-cmk"
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group

  sku_name   = "GP_Gen5_2"
  version    = "11"
  storage_mb = 51200

  administrator_login          = random_string.this.result
  administrator_login_password = random_password.this.result

  ssl_enforcement_enabled = true

  identity {
    type = "SystemAssigned"
  }

  tags = module.naming.default_tags
}

resource "azurerm_postgresql_server_key" "this" {
  server_id        = azurerm_postgresql_server.cmk.id
  key_vault_key_id = data.terraform_remote_state.common.outputs.key_id
}
