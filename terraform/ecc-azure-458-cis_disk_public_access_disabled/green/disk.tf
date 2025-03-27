resource "azurerm_managed_disk" "this" {
  name                 = "${var.prefix}managed_disks_green"
  location             = azurerm_resource_group.this.location
  resource_group_name  = azurerm_resource_group.this.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"
  public_network_access_enabled = false
  network_access_policy = "DenyAll"

  tags = var.tags
}
