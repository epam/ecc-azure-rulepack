resource "random_password" "this" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "random_string" "this" {
  length  = 8
  number  = true
  special = false
}