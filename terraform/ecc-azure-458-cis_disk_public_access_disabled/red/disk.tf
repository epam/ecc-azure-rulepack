resource "azurerm_managed_disk" "this" {
  name                 = "${var.prefix}managed_disks_red"
  location             = azurerm_resource_group.this.location
  resource_group_name  = azurerm_resource_group.this.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"
  public_network_access_enabled = true

  tags = var.tags
}
