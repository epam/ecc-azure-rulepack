resource "azurerm_key_vault_access_policy" "appgw" {
  key_vault_id = data.terraform_remote_state.common.outputs.key_vault_id
  tenant_id    = azurerm_application_gateway.this.identity[0].tenant_id
  object_id    = azurerm_application_gateway.this.identity[0].principal_id

  key_permissions    = ["Get", "UnwrapKey", "WrapKey"]
  secret_permissions = ["Get"]
  certificate_permissions = [
      "Create",
      "Delete",
      "DeleteIssuers",
      "Get",
      "GetIssuers",
      "Import",
      "List",
      "ListIssuers",
      "ManageContacts",
      "ManageIssuers",
      "SetIssuers",
      "Update",
    ]
}


resource "azurerm_key_vault_certificate" "this" {
  name         = "green-appgw-cert"
  key_vault_id = data.terraform_remote_state.common.outputs.key_vault_id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 30
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      # Server Authentication = 1.3.6.1.5.5.7.3.1
      # Client Authentication = 1.3.6.1.5.5.7.3.2
      extended_key_usage = ["1.3.6.1.5.5.7.3.1", "1.3.6.1.5.5.7.3.2"]

      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      # subject_alternative_names {
      #   dns_names = ["internal.contoso.com", "domain.hello.world"]
      # }

      subject            = "CN=yourorg.com"
      validity_in_months = 12
    }
  }
}