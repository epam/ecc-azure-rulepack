resource "azurerm_data_factory" "this" {
  name                = module.naming.resource_prefix.datafactory
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  github_configuration {
    account_name    = "alyonaserdiuk"
    branch_name     = "develop"
    git_url         = "https://github.com/alyonaserdiuk/juice-shop.git"
    repository_name = "alyonaserdiuk/juice-shop"
    root_folder     = "/"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }

  tags = module.naming.default_tags
}

