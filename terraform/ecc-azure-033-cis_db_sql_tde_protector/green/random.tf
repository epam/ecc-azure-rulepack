resource "random_password" "this" {
  length  = 13
  special = true
  number  = false
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