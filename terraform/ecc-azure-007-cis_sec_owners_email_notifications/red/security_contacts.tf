# Owner access permission is required
resource "azurerm_security_center_contact" "this" {
  email               = "test1@example.com"
  alert_notifications = false
  alerts_to_admins    = false
}