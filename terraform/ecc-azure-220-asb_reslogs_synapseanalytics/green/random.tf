resource "random_password" "this" {
  length           = 16
  numeric           = true
  special          = true
  override_special = "_%@"
}

resource "random_string" "this" {
  length  = 8
  numeric  = false
  special = false
}
