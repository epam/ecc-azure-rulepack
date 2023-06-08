resource "random_password" "this" {
  length           = 17
  special          = true
  number           = false
  override_special = "_%@"
}

resource "random_string" "this" {
  length  = 8
  number  = false
  special = false
}