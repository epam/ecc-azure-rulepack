resource "azurerm_cognitive_account" "this" {
  name                = "${var.prefix}-account"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  kind                = "CustomVision.Training"
  sku_name            = "S0"


  identity {
    type = "SystemAssigned, UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.this.id
    ]
  }

  tags = var.tags
}

resource "azurerm_user_assigned_identity" "this" {
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  name = "cognitive-uai${var.prefix}"
}

resource "azurerm_cognitive_account_customer_managed_key" "this" {
  cognitive_account_id = azurerm_cognitive_account.this.id
  key_vault_key_id     = azurerm_key_vault_key.this.id
  identity_client_id   = azurerm_user_assigned_identity.this.client_id
}