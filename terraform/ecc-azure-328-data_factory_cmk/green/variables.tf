variable "prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "object_id" {
  type      = string
  sensitive = true
}


variable "tags" {
  type = map(string)
}