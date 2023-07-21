resource "azurerm_virtual_machine_scale_set_extension" "ext1" {
  virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.vmsswin1.id
  auto_upgrade_minor_version   = true
  name                         = "MicrosoftMonitoringAgent"
  publisher                    = "Microsoft.EnterpriseCloud.Monitoring"
  type                         = "MicrosoftMonitoringAgent"
  type_handler_version         = "1.0"
}

resource "azurerm_virtual_machine_scale_set_extension" "ext2" {
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.vmsslin2.id
  auto_upgrade_minor_version   = true
  name                         = "MicrosoftMonitoringAgent"
  publisher                    = "Microsoft.EnterpriseCloud.Monitoring"
  type                         = "OmsAgentForLinux"
  type_handler_version         = "1.10"
}