resource "random_password" "this" {
  length  = 13
  special = true
  numeric = true
}

resource "random_string" "this" {
  length  = 8
  numeric = false
  special = false
}