resource "azurerm_container_registry" "this" {
  name                = "${var.prefix}containerRegistry"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Premium"

  encryption {
    enabled            = true
    key_vault_key_id   = azurerm_key_vault_key.key.id
    identity_client_id = azurerm_user_assigned_identity.this.client_id
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.this.id
    ]
  }

  tags = var.tags
}

resource "azurerm_user_assigned_identity" "this" {
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  name = "registry-uai${var.prefix}"
}