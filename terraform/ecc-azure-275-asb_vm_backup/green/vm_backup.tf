resource "azurerm_recovery_services_vault" "this" {
  name                = "rsv${var.prefix}green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_backup_policy_vm" "this" {
  name                = "policy${var.prefix}green"
  resource_group_name = azurerm_resource_group.this.name
  recovery_vault_name = azurerm_recovery_services_vault.this.name

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 7
  }
}

resource "azurerm_backup_protected_vm" "this" {
  resource_group_name = azurerm_resource_group.this.name
  recovery_vault_name = azurerm_recovery_services_vault.this.name
  source_vm_id        = azurerm_linux_virtual_machine.this.id
  backup_policy_id    = azurerm_backup_policy_vm.this.id
}