resource "azurerm_role_definition" "CustomRole_1" {
  name        = "${var.prefix}CustomRole_cis_iam_owner_roles_1_red"
  scope       = data.azurerm_subscription.primary.id
  description = "This Role definition should be filtered by Custodian rule - ecc-azure-002-cis-iam-owner-roles.yml"

  permissions {
    actions = ["*"]
  }
  assignable_scopes = [data.azurerm_subscription.primary.id]
}

resource "azurerm_role_definition" "CustomRole_2" {
  name        = "${var.prefix}CustomRole_cis_iam_owner_roles_2_red"
  scope       = data.azurerm_subscription.primary.id
  description = "This Role definition shouldn't be filtered by Custodian rule - ecc-azure-002-cis-iam-owner-roles.yml"

  permissions {
    actions = ["*"]
  }

  assignable_scopes = ["${data.azurerm_subscription.primary.id}/resourcegroup"]
}