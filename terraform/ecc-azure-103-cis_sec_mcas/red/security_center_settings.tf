# Owner access permission is required
provider "azurerm" {
  features {}
}

resource "azurerm_security_center_setting" "MCAS" {
  setting_name = "MCAS"
  enabled      = false
}