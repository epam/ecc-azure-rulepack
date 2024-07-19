resource "random_password" "this" {
  length  = 13
  special = true
  number  = true
}

resource "random_string" "this" {
  length  = 8
  number  = false
  special = false
}