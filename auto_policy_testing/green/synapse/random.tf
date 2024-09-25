resource "random_password" "this" {
  length           = 16
  numeric          = true
  special          = true
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
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
