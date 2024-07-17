resource "random_password" "this" {
  length  = 15
  special = true
  number  = true
  override_special = "_%@"
}

resource "random_string" "this" {
  length  = 8
  numeric = false
  special = false
}