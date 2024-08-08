resource "random_password" "this" {
  length           = 13
  special          = true
  numeric  = true
  min_lower = 1
  min_numeric = 1
  min_special = 1
  min_upper   = 1
  override_special = "_%@"
}

resource "random_string" "this" {
  length  = 8
  number  = false
  special = false
}