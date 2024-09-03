output "vm" {
  value = {
    ecc-azure-116-cis_vm_endpoint_protection = azurerm_windows_virtual_machine.this.id,
    ecc-azure-132-vm_wo_del_lock = azurerm_linux_virtual_machine.this.id,
    ecc-azure-197-asb_vm_disk_encryption_on = azurerm_windows_virtual_machine.this.id,
    ecc-azure-275-asb_vm_backup = azurerm_windows_virtual_machine.this.id,
    ecc-azure-337-vm_antimalware_auto_updates = azurerm_windows_virtual_machine.this.id,
    ecc-azure-353-vmss_auto_image_patching = azurerm_linux_virtual_machine_scale_set.this.id,
    ecc-azure-367-vm_omi_vulnerability = azurerm_windows_virtual_machine.this.id,
    ecc-azure-412-cis_tpm_and_secure_boot = azurerm_windows_virtual_machine.this.id,
    ecc-azure-227-asb_reslogs_vmss = azurerm_windows_virtual_machine_scale_set.this1.id,
    ecc-azure-368-vmss_omi_vulnerability = azurerm_linux_virtual_machine_scale_set.this1.id,
    ecc-azure-272-asb_scaleset = azurerm_windows_virtual_machine_scale_set.this1.id,
    ecc-azure-232-asb_vmss_wo_mma = azurerm_windows_virtual_machine_scale_set.this.id,
    vm = [azurerm_windows_virtual_machine.this.id, azurerm_linux_virtual_machine.this.id],
    vmss = [azurerm_windows_virtual_machine_scale_set.this.id, azurerm_linux_virtual_machine_scale_set.this.id]
  }
}


