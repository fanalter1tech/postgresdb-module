variable "regions" {
  default = []
}

variable "env_name" {
  type = string
  default = "dev"
}

variable "start_ip_address" {
  type = string
}

variable "end_ip_address" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "admin_login" {
  type = string
}

variable "admin_login_password" {
  type = string
}

variable "charset" {
  type = string
  default = "UTF8"
}

variable "collation" {
  type = string
  default = "English_United States.1252"
}