resource "azurerm_virtual_machine_extension" "linuxvm_extension" {
  name                 = "linux1ext"
  virtual_machine_id   = azurerm_linux_virtual_machine.this.id
  publisher            = "Microsoft.GuestConfiguration"
  type                 = "ConfigurationForLinux"
  type_handler_version = "1.0"
}

resource "azurerm_virtual_machine_extension" "this" {
  name                 = "OmsAgentForLinux"
  virtual_machine_id   = azurerm_linux_virtual_machine.this.id
  publisher            = "Microsoft.EnterpriseCloud.Monitoring"
  type                 = "OmsAgentForLinux"
  type_handler_version = "1.12"

  settings           = <<SETTINGS
    {
      "workspaceId": "${data.terraform_remote_state.common.outputs.workspace_id}"
    }
    SETTINGS   
  protected_settings = <<PROTECTED_SETTINGS
    {
      "workspaceKey": "${data.terraform_remote_state.common.outputs.workspace_key}"
    }
    PROTECTED_SETTINGS
}

resource "azurerm_virtual_machine_scale_set_extension" "this" {
  name                         = "OmsAgentForLinux"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.this.id
  publisher                    = "Microsoft.EnterpriseCloud.Monitoring"
  type                         = "OmsAgentForLinux"
  type_handler_version         = "1.12"

  settings           = <<SETTINGS
    {
      "workspaceId": "${data.terraform_remote_state.common.outputs.workspace_id}"
    }
    SETTINGS   
  protected_settings = <<PROTECTED_SETTINGS
    {
      "workspaceKey": "${data.terraform_remote_state.common.outputs.workspace_key}"
    }
    PROTECTED_SETTINGS
}