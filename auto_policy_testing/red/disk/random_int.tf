resource "random_integer" "this" {
  min = 1
  max = 100
}

resource "random_password" "this" {
  length  = 15
  special = true
  numeric  = true
  min_lower = 1
  min_numeric = 1
  min_special = 1
  min_upper   = 1
  override_special = "_%@"
}

resource "random_string" "this" {
  length  = 8
  numeric = false
  special = false
}