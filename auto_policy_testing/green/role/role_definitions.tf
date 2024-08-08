data "azurerm_subscription" "primary" {}

resource "azurerm_role_definition" "this" {
  name        = module.naming.resource_prefix.roledefinition
  scope       = data.azurerm_subscription.primary.id
  description = "This Role definition should be filtered by Custodian rule - ecc-azure-002-cis-iam-owner-roles.yml"

  permissions {
    actions = ["Microsoft.Resources/subscriptions/resourceGroups/read"]
  }
  assignable_scopes = [data.azurerm_subscription.primary.id]
}