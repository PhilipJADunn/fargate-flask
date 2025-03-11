variable "tags" {
  type = map(string)
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "flask_private_subnet" {
  type = list(string)
}

variable "flask_public_subnet" {
  type = list(string)
}