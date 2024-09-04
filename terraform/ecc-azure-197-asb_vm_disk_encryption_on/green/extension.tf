resource "azurerm_virtual_machine_extension" "this" {
    name                              =     "AzureDiskEncryption"
    virtual_machine_id                =     azurerm_linux_virtual_machine.this.id
    publisher                         =     "Microsoft.Azure.Security"
    type                              =     "AzureDiskEncryptionForLinux"
    type_handler_version              =     "1.1"
    auto_upgrade_minor_version        =     true

    settings = <<SETTINGS
    {
        "EncryptionOperation"         :     "EnableEncryption",
        "KeyVaultURL"                 :     "${azurerm_key_vault.this.vault_uri}",
        "KeyVaultResourceId"          :     "${azurerm_key_vault.this.id}",
        "KeyEncryptionKeyURL"         :     "${azurerm_key_vault_key.this.id}",
        "KekVaultResourceId"          :     "${azurerm_key_vault.this.id}",
        "KeyEncryptionAlgorithm"      :     "RSA-OAEP",
        "VolumeType"                  :     "All"
    }
    SETTINGS

    depends_on                        =     [azurerm_linux_virtual_machine.this]
}