resource "random_integer" "this" {
  min = 1
  max = 100
}

resource "random_password" "this" {
  length  = 13
  special = true
  numeric  = true
  override_special = "_%@"
}

resource "random_string" "this" {
  length  = 8
  numeric = false
  special = false
}