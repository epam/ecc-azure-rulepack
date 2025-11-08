output "defender" {
  value = {
    #defender-autoprovisioning                       = azurerm_security_center_auto_provisioning.this.id,
    
    ecc-azure-094-cis_sec_defender_servers          = azurerm_security_center_subscription_pricing.servers.id,
    ecc-azure-095-cis_sec_defender_app              = azurerm_security_center_subscription_pricing.app.id,
    ecc-azure-096-cis_sec_defender_azure_sql        = azurerm_security_center_subscription_pricing.azure_sql.id,
    ecc-azure-097-cis_sec_defender_sql_machines     = azurerm_security_center_subscription_pricing.sql_machines.id,
    ecc-azure-098-cis_sec_defender_storages         = azurerm_security_center_subscription_pricing.storages.id,
    ecc-azure-099-cis_sec_defender_aks              = azurerm_security_center_subscription_pricing.aks.id,
    ecc-azure-100-cis_sec_defender_acr              = azurerm_security_center_subscription_pricing.acr.id,
    ecc-azure-214-asb_defender_arm                  = azurerm_security_center_subscription_pricing.arm.id,
    ecc-azure-310-asb_defender_open_source_rds      = azurerm_security_center_subscription_pricing.os_rds.id,
    ecc-azure-376-cis_defender_cosmodb              = azurerm_security_center_subscription_pricing.cosmodb.id,
    ecc-azure-101-cis_sec_defender_keyvaults        = azurerm_security_center_subscription_pricing.keyvaults.id,
    ecc-azure-213-asb_lt_defender_dns               = azurerm_security_center_subscription_pricing.dns.id,
    ecc-azure-470-cis_sec_agentless_scan            = azurerm_security_center_subscription_pricing.agentless.id,
    
    #ecc-azure-102-cis_sec_defender_wdatp            = azurerm_security_center_setting.WDATP.id,
    #ecc-azure-103-cis_sec_mcas                      = azurerm_security_center_setting.MCAS.id,

    defender-assessment                             = azurerm_windows_virtual_machine.this.id,
    defender-contact                                = azurerm_security_center_contact.this.id
  }
}