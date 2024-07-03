output "vm" {
  value = {
    ecc-azure-113-cis_vm_utilizing_managed_disks = azurerm_virtual_machine.this.id,
    ecc-azure-117-cis_vm_vhd_encrypted = azurerm_virtual_machine.this.id,
    ecc-azure-184-asb_vm_linux_ssh_auth_req = azurerm_linux_virtual_machine.this.id,
    ecc-azure-215-asb_networktraffic_linuxvm = azurerm_linux_virtual_machine.this.id,
    ecc-azure-216-asb_networktraffic_winvm = azurerm_windows_virtual_machine.this.id,
    ecc-azure-228-asb_guest_extension = azurerm_windows_virtual_machine.this.id,
    ecc-azure-231-asb_vm_wo_mma = azurerm_windows_virtual_machine.this.id,
    ecc-azure-232-asb_vmss_wo_mma = azurerm_windows_virtual_machine_scale_set.this.id,
    ecc-azure-234-asb_guest_extension_mi = azurerm_linux_virtual_machine.this.id,
    ecc-azure-323-linux_vmss_ssh = azurerm_linux_virtual_machine_scale_set.this.id,
    ecc-azure-368-vmss_omi_vulnerability = azurerm_linux_virtual_machine_scale_set.this.id,
    ecc-azure-367-vm_omi_vulnerability = azurerm_linux_virtual_machine.this.id,
    vm = [azurerm_windows_virtual_machine.this.id, azurerm_linux_virtual_machine.this.id],
    vmss = [azurerm_windows_virtual_machine_scale_set.this.id, azurerm_linux_virtual_machine_scale_set.this.id]
  }
}


