resource "random_password" "this" {
  length    = 13
  special   = true
  number    = true
  min_upper = 1
}

resource "random_string" "this" {
  length  = 8
  number  = true
  special = false
}