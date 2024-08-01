resource "azurerm_postgresql_server" "this" {
  name                          = module.naming.resource_prefix.postgresql-server
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group

  administrator_login          = random_string.this.result
  administrator_login_password = random_password.this.result

  sku_name   = "GP_Gen5_4"
  version    = "9.6"
  storage_mb = 640000

  backup_retention_days        = 7
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true
  infrastructure_encryption_enabled = true

  public_network_access_enabled    = false
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"

  threat_detection_policy {
    enabled = true
  }

  identity {
    type = "SystemAssigned"
  }

  tags = module.naming.default_tags
}

resource "azurerm_postgresql_server_key" "this" {
  server_id        = azurerm_postgresql_server.this.id
  key_vault_key_id = data.terraform_remote_state.common.outputs.key_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_postgresql_configuration" "log_checkpoints" {
  name                = "log_checkpoints"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  server_name         = azurerm_postgresql_server.this.name
  value               = "on"
}

resource "azurerm_postgresql_configuration" "log_connections" {
  name                = "log_connections"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  server_name         = azurerm_postgresql_server.this.name
  value               = "on"
}

resource "azurerm_postgresql_configuration" "log_disconnections" {
  name                = "log_disconnections"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  server_name         = azurerm_postgresql_server.this.name
  value               = "on"
}

resource "azurerm_postgresql_configuration" "connection_throttling" {
  name                = "connection_throttling"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  server_name         = azurerm_postgresql_server.this.name
  value               = "on"
}

resource "azurerm_postgresql_configuration" "log_retention_days" {
  name                = "log_retention_days"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  server_name         = azurerm_postgresql_server.this.name
  value               = 5
}

resource "azurerm_postgresql_configuration" "logging_collector" {
  name                = "logging_collector"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  server_name         = azurerm_postgresql_server.this.name
  value               = "on"
}

resource "azurerm_postgresql_configuration" "log_min_messages" {
  name                = "log_min_messages"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  server_name         = azurerm_postgresql_server.this.name
  value               = "warning"
}

resource "azurerm_postgresql_configuration" "debug_print_plan" {
  name                = "debug_print_plan"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  server_name         = azurerm_postgresql_server.this.name
  value               = "off"
}

resource "azurerm_postgresql_configuration" "log_error_verbosity" {
  name                = "log_error_verbosity"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  server_name         = azurerm_postgresql_server.this.name
  value               = "verbose"
}

resource "azurerm_postgresql_configuration" "log_line_prefix" {
  name                = "log_line_prefix"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  server_name         = azurerm_postgresql_server.this.name
  value               = "%m [%p]: [%l-1], db=%d,user=%u,app=%a,client=%h,"

  depends_on = [
    azurerm_postgresql_server.this
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_postgresql_configuration" "log_min_error_statement" {
  name                = "log_min_error_statement"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  server_name         = azurerm_postgresql_server.this.name
  value               = "error"
}

resource "azurerm_postgresql_configuration" "log_statement" {
  name                = "log_statement"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  server_name         = azurerm_postgresql_server.this.name
  value               = "ddl"
}
