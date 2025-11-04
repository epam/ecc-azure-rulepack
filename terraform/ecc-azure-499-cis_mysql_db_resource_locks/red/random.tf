resource "random_password" "this" {
  length           = 16
  special          = true
  numeric          = true
  upper            = true
  lower            = true
  override_special = "_%@"
}

resource "random_string" "this" {
  length  = 8
  numeric = false
  special = false
}