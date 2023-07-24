resource "random_password" "this" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "random_string" "this" {
  length  = 8
  number  = false
  special = false
}

resource "random_integer" "this" {
  min = 1
  max = 100
}