resource "azurerm_recovery_services_vault" "this" {
  name                = "rsv-vm-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Standard"
  soft_delete_enabled = false

  tags = var.tags
}

resource "azurerm_backup_policy_vm" "this" {
  name                = "policyvmgreen"
  resource_group_name = azurerm_resource_group.this.name
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
  resource_group_name = azurerm_resource_group.this.name
  recovery_vault_name = azurerm_recovery_services_vault.this.name
  source_vm_id        = azurerm_windows_virtual_machine.this.id
  backup_policy_id    = azurerm_backup_policy_vm.this.id
}