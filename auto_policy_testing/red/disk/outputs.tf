output "disk" {
  value = {
    disk                                = azurerm_managed_disk.this1.id,
    ecc-azure-053-cis_vm_attached_disks = azurerm_managed_disk.this2.id,
    ecc-azure-439-disable_premium_ssd   = azurerm_managed_disk.this2.id
  }
}