resource "azurerm_recovery_services_vault" "this" {
  name                = module.naming.resource_prefix.recoveryvault
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  sku                 = "Standard"
  soft_delete_enabled = false

  tags = module.naming.default_tags
}

resource "azurerm_backup_policy_vm" "this" {
  name                = "policyvmgreen"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  recovery_vault_name = azurerm_recovery_services_vault.this.name
  policy_type = "V2"

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 10
  }
}

resource "azurerm_backup_protected_vm" "this" {
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  recovery_vault_name = azurerm_recovery_services_vault.this.name
  source_vm_id        = azurerm_windows_virtual_machine.this.id
  backup_policy_id    = azurerm_backup_policy_vm.this.id
}