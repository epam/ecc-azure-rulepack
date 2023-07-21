resource "azurerm_managed_disk" "this" {
  name                   = "${var.prefix}managed_disks_green"
  location               = azurerm_resource_group.this.location
  resource_group_name    = azurerm_resource_group.this.name
  storage_account_type   = "Standard_LRS"
  create_option          = "Empty"
  disk_size_gb           = "1"
  disk_encryption_set_id = azurerm_disk_encryption_set.this.id

  tags = var.tags
}