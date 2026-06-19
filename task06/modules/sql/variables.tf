variable "creator" {
  type        = string
  description = "name of creator"
}
variable "server_name" {
  type        = string
  description = "name of sql name "
}
variable "db_name" {
  type        = string
  description = "name of  db  name "
}
variable "administrator_login" {
  type        = string
  description = "name of key vault"
}
variable "administrator_password" {
  type        = string
  description = "password of key vault for sql"
}
variable "region" {
  type        = string
  description = "Region of rescource"
}
variable "tenant_id" {
  type        = string
  description = "tenand ID"
}
variable "rg_name" {
  type        = string
  description = "name of resource group"
}
variable "allowed_ip_address" {
  type        = string
  description = "IP address verification"
}
variable "name_of_firewall" {
  type        = string
  description = "Name of String"
}

