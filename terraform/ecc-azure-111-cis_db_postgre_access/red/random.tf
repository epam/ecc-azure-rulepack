resource "random_password" "this" {
  length           = 16
  special          = true
  number           = true
  override_special = "_%@"
}

resource "random_string" "this" {
  length  = 8
  number  = false
  special = false
}