resource "random_password" "this" {
  length           = 17
  special          = true
  override_special = "_%@"
}

resource "random_string" "this" {
  length  = 8
  number  = true
  special = false
}