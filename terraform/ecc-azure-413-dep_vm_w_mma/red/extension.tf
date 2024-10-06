locals {
  workspaceKey = azurerm_log_analytics_workspace.this.primary_shared_key
  workspaceId  = azurerm_log_analytics_workspace.this.workspace_id
}

resource "azurerm_virtual_machine_extension" "linuxvm_ext" {
  name                 = "${var.prefix}linuxext"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm1.id
  publisher            = "Microsoft.EnterpriseCloud.Monitoring"
  type                 = "OmsAgentForLinux"
  type_handler_version = "1.13"

  settings           = <<SETTINGS
    {
      "workspaceId": "${local.workspaceId}"
    }
    SETTINGS   
  protected_settings = <<PROTECTED_SETTINGS
    {
      "workspaceKey": "${local.workspaceKey}"
    }
    PROTECTED_SETTINGS

  tags = var.tags

  depends_on = [azurerm_log_analytics_workspace.this]
}
resource "azurerm_virtual_machine_extension" "winvm_ext" {
  name                 = "${var.prefix}winext"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm2.id
  publisher            = "Microsoft.EnterpriseCloud.Monitoring"
  type                 = "MicrosoftMonitoringAgent"
  type_handler_version = "1.0"

  settings           = <<SETTINGS
    {
      "workspaceId": "${local.workspaceId}"
    }
    SETTINGS   
  protected_settings = <<PROTECTED_SETTINGS
    {
      "workspaceKey": "${local.workspaceKey}"
    }
    PROTECTED_SETTINGS

  tags = var.tags

  depends_on = [azurerm_log_analytics_workspace.this]
}