resource "azurerm_virtual_machine_extension" "linuxvm_extension" {
  name                 = "linux1ext"
  virtual_machine_id   = azurerm_linux_virtual_machine.this.id
  publisher            = "Microsoft.GuestConfiguration"
  type                 = "ConfigurationForLinux"
  type_handler_version = "1.0"

  tags = var.tags
}

locals {
  workspaceKey = azurerm_log_analytics_workspace.this.primary_shared_key
  workspaceId  = azurerm_log_analytics_workspace.this.workspace_id
}

resource "azurerm_virtual_machine_extension" "this" {
  name                 = "OmsAgentForLinux"
  virtual_machine_id   = azurerm_linux_virtual_machine.this.id
  publisher            = "Microsoft.EnterpriseCloud.Monitoring"
  type                 = "OmsAgentForLinux"
  type_handler_version = "1.12"

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

resource "azurerm_virtual_machine_scale_set_extension" "this" {
  name                         = "OmsAgentForLinux"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.this.id
  publisher                    = "Microsoft.EnterpriseCloud.Monitoring"
  type                         = "OmsAgentForLinux"
  type_handler_version         = "1.12"

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


  depends_on = [azurerm_log_analytics_workspace.this]
}