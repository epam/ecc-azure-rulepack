resource "random_password" "this" {
  length    = 15
  special   = true
  numeric   = true
  override_special = "_%@"
}

resource "random_string" "this" {
  length  = 8
  number  = false
  special = false
}