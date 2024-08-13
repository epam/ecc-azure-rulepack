output "defender" {
  value = {
    defender-autoprovisioning = azurerm_security_center_auto_provisioning.this.id,
    defender-pricing = [
      azurerm_security_center_subscription_pricing.servers.id,
      azurerm_security_center_subscription_pricing.app.id,
      azurerm_security_center_subscription_pricing.azure_sql.id,
      azurerm_security_center_subscription_pricing.sql_machines.id,
      azurerm_security_center_subscription_pricing.aks.id,
      azurerm_security_center_subscription_pricing.acr.id,
      azurerm_security_center_subscription_pricing.dns.id,
      azurerm_security_center_subscription_pricing.arm.id,
      azurerm_security_center_subscription_pricing.os_rds.id,
      azurerm_security_center_subscription_pricing.cosmodb.id,
      azurerm_security_center_subscription_pricing.storages.id,
      azurerm_security_center_subscription_pricing.keyvaults.id
    ],
    defender-setting = [
      azurerm_security_center_setting.WDATP.id,
      azurerm_security_center_setting.MCAS.id
    ],
    defender-assessment = azurerm_windows_virtual_machine.this.id,
    defender-contact = azurerm_security_center_contact.this.id
  }
}