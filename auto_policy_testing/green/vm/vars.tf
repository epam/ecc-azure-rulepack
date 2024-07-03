variable "location" {
  type = string
}

variable "public_key" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "remote_state_region" {
  type        = string
  description = "Region where resources will be created"
  default     = "us-east-1"
}

variable "remote_state_bucket" {
  type        = string
}

variable "remote_state_key" {
  type        = string
}