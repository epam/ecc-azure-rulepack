output "storage" {
  value = {
    storage = azurerm_storage_account.this.id,
    ecc-azure-010-cis_sa_net_defaultAction = azurerm_storage_account.this1.id,
    ecc-azure-159-asb_sa_restrict_net_access_vnet_rules = azurerm_storage_account.this1.id,
    ecc-azure-478-cis_sa_entraid_authorization = azurerm_storage_account.this1.id,
    ecc-azure-481-cis_sa_public_network_access = azurerm_storage_account.this1.id
  }
}