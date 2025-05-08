resource "azurerm_databricks_workspace" "this" {
  name                = "${var.prefix}databricks-green"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "premium"

  managed_resource_group_name = "${var.prefix}-DBW-managed-dbfs"

  customer_managed_key_enabled = true

  tags = var.tags
}

resource "azurerm_databricks_workspace_root_dbfs_customer_managed_key" "this" {
  depends_on = [azurerm_key_vault_access_policy.databricks]

  workspace_id     = azurerm_databricks_workspace.this.id
  key_vault_key_id = azurerm_key_vault_key.this.id
}