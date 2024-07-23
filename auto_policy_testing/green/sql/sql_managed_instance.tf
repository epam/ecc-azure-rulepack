resource "azurerm_mssql_managed_instance" "this" {
  name                          = module.naming.resource_prefix.sql-managed-instance
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group

  license_type       = "BasePrice"
  sku_name           = "GP_Gen5"
  storage_size_in_gb = 32
  subnet_id          = azurerm_subnet.this.id
  vcores             = 4

  administrator_login          = random_string.this.result
  administrator_login_password = random_password.this.result

  identity {
    type = "SystemAssigned"
  }

  tags = module.naming.default_tags

  depends_on = [
    azurerm_subnet_network_security_group_association.this,
    azurerm_subnet_route_table_association.this,
  ]
}

resource "azurerm_mssql_managed_instance_security_alert_policy" "this" {
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  managed_instance_name      = azurerm_mssql_managed_instance.this.name
  enabled                    = true
  storage_endpoint           = data.terraform_remote_state.common.outputs.storage_blob_endpoint
  storage_account_access_key = data.terraform_remote_state.common.outputs.storage_key
  
  retention_days = 20
}

resource "azurerm_mssql_managed_instance_transparent_data_encryption" "this" {
  managed_instance_id = azurerm_mssql_managed_instance.this.id
  key_vault_key_id    = data.terraform_remote_state.common.outputs.key_id
}

resource "azurerm_mssql_managed_instance_vulnerability_assessment" "this" {
  managed_instance_id        = azurerm_mssql_managed_instance.this.id
  storage_container_path     = "${data.terraform_remote_state.common.outputs.storage_blob_endpoint}${data.terraform_remote_state.common.outputs.storage_container_name}/"
  storage_account_access_key = data.terraform_remote_state.common.outputs.storage_key

  recurring_scans {
    enabled                   = true
    email_subscription_admins = true
    emails = [
      "email@example1.com",
      "email@example2.com"
    ]
  }
  depends_on = [azurerm_mssql_managed_instance_security_alert_policy.this]
}