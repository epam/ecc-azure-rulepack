output "postgresql" {
  value = {
    postgresql-server = azurerm_postgresql_server.this.id
    #ecc-azure-203-asb_postgresql_encrypt_cmk = azurerm_postgresql_server.cmk.id
  }
}