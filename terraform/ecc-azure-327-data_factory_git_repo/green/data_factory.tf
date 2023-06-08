resource "azurerm_data_factory" "this" {
  name                = "kusto${var.prefix}green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  github_configuration {
    account_name    = "alyonaserdiuk"
    branch_name     = "develop"
    git_url         = "https://github.com/alyonaserdiuk/juice-shop.git"
    repository_name = "alyonaserdiuk/juice-shop"
    root_folder     = "/"
  }

  tags = var.tags
}