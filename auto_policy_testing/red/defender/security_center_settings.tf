resource "azurerm_security_center_setting" "WDATP" {
  setting_name = "WDATP"
  enabled      = false
}

resource "azurerm_security_center_setting" "MCAS" {
  setting_name = "MCAS"
  enabled      = false
}