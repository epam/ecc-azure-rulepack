resource "random_password" "this" {
  length           = 16
  number           = true
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
  max = 1000
}
