resource "azurerm_virtual_machine_extension" "win1" {
  name                 = "IaaSAntimalware"
  virtual_machine_id   = azurerm_windows_virtual_machine.this.id
  publisher            = "Microsoft.Azure.Security"
  type                 = "IaaSAntimalware"
  type_handler_version = "1.3"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "AntimalwareEnabled": true,
      "RealtimeProtectionEnabled": "false",
      "ScheduledScanSettings": {
          "isEnabled": "false",
          "day": "7",
          "time": "120",
          "scanType": "Quick"
      },
      "Exclusions": {
          "Extensions": "",
          "Paths": "",
          "Processes": ""
      }
    }
  SETTINGS

  tags = module.naming.default_tags

  depends_on = [azurerm_windows_virtual_machine.this]
}

resource "azurerm_virtual_machine_extension" "win2" {
  name                 = "vm-win3ext"
  virtual_machine_id   = azurerm_windows_virtual_machine.this.id
  publisher            = "Microsoft.GuestConfiguration"
  type                 = "ConfigurationforWindows"
  type_handler_version = "1.11"

  tags = module.naming.default_tags

  depends_on = [azurerm_virtual_machine_extension.win1]
}

resource "azurerm_virtual_machine_extension" "win3" {
  virtual_machine_id   = azurerm_windows_virtual_machine.this.id
  name                       = "AzureMonitorWindowsAgent"
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorWindowsAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = "true"

  depends_on = [azurerm_virtual_machine_extension.win2]
}

resource "azurerm_virtual_machine_extension" "win4" {
  name                 = "dependencyextensiongreen"
  virtual_machine_id   = azurerm_windows_virtual_machine.this.id
  publisher            = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                 = "DependencyAgentWindows"
  type_handler_version = "9.5"

  tags = module.naming.default_tags

  depends_on = [azurerm_virtual_machine_extension.win3]
}

resource "azurerm_virtual_machine_extension" "win5" {
    #count                             =     "windows"
    name                              =     "AzureDiskEncryption"
    virtual_machine_id                =     azurerm_windows_virtual_machine.this.id
    publisher                         =     "Microsoft.Azure.Security"
    type                              =     "AzureDiskEncryption"
    type_handler_version              =     "2.2"
    auto_upgrade_minor_version        =     true

    settings = <<SETTINGS
    {
        "EncryptionOperation"         :     "EnableEncryption",
        "KeyVaultURL"                 :     "${data.terraform_remote_state.common.outputs.key_vault_url}",
        "KeyVaultResourceId"          :     "${data.terraform_remote_state.common.outputs.key_vault_id}",
        "KeyEncryptionKeyURL"         :     "${data.terraform_remote_state.common.outputs.key_id}",
        "KekVaultResourceId"          :     "${data.terraform_remote_state.common.outputs.key_vault_id}",
        "KeyEncryptionAlgorithm"      :     "RSA-OAEP",
        "VolumeType"                  :     "All"
    }
    SETTINGS

    tags = module.naming.default_tags

    depends_on                        =     [azurerm_virtual_machine_extension.win4]
}

resource "azurerm_virtual_machine_scale_set_extension" "vmsswin1" {
  name                         = "IaaSAntimalware"
  virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.this.id
  publisher                    = "Microsoft.Azure.Security"
  type                         = "IaaSAntimalware"
  type_handler_version         = "1.5"
  
}

resource "azurerm_virtual_machine_scale_set_extension" "vmsswin2" {
  name                         = "wvmssdiagext"
  virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.this.id
  publisher                    = "Microsoft.Azure.Diagnostics"
  type                         = "IaaSDiagnostics"
  type_handler_version         = "1.1"

  depends_on = [azurerm_virtual_machine_scale_set_extension.vmsswin1]
}

resource "azurerm_virtual_machine_scale_set_extension" "vmsswin3" {
  virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.this.id
  name                       = "AzureMonitorWindowsAgent"
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorWindowsAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = "true"

  depends_on = [azurerm_virtual_machine_scale_set_extension.vmsswin2]
}

resource "azurerm_virtual_machine_scale_set_extension" "vmsswin11" {
  name                         = "wvmssdiagext"
  virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.this1.id
  publisher                    = "Microsoft.Azure.Diagnostics"
  type                         = "IaaSDiagnostics"
  type_handler_version         = "1.1"
}

resource "azurerm_virtual_machine_scale_set_extension" "vmsswin12" {
  name                         = "IaaSAntimalware"
  virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.this1.id
  publisher                    = "Microsoft.Azure.Security"
  type                         = "IaaSAntimalware"
  type_handler_version         = "1.5"
  depends_on = [azurerm_virtual_machine_scale_set_extension.vmsswin11]
}
