data "azurerm_client_config" "current" {}

resource "azurerm_storage_account" "this" {
  name                            = "${module.naming.resource_prefix.storage}monitor${random_integer.this.result}"
  location                        = data.terraform_remote_state.common.outputs.location
  resource_group_name             = data.terraform_remote_state.common.outputs.resource_group
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false

  identity {
    type = "SystemAssigned"
  }

  tags = module.naming.default_tags
}

resource "azurerm_monitor_log_profile" "this" {
  name               = "log-profile-red"
  storage_account_id = azurerm_storage_account.this.id
  locations          = [data.terraform_remote_state.common.outputs.location]

  categories = [
    "Action",
    "Delete",
    "Write",
  ]

  retention_policy {
    enabled = false
  }

}