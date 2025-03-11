variable "environment" {
  type    = string
  default = "stag"
}

variable "vpc_id" {
  type    = string
  default = "vpc-05e715743bd052660"
}

variable "flask_private_subnet" {
  type    = list(string)
  default = ["subnet-0a88731bddf6a6695", "subnet-076401ba17958c172", "subnet-0f72e8950dbb64c3e"]
}

variable "flask_public_subnet" {
  type    = list(string)
  default = ["subnet-085ee9f35c296a55b", "subnet-0f42472cb9af797a9", "subnet-0bc957df8395b4b14"]
}