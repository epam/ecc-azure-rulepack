# Owner access permission is required
resource "azurerm_security_center_setting" "WDATP" {
  setting_name = "WDATP"
  enabled      = false
}