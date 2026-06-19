variable "creator" {
  type        = string
  description = "name of creator"
}
variable "project" {
  type        = string
  description = "name of project"
}
variable "env_name" {
  type        = string
  description = "Name of Enviroment"
}
variable "module_name" {
  type        = string
  description = "Name of module"
}
variable "region" {
  type        = string
  description = "Region of rescource"
}
variable "existed_key_vault_name" {
  type        = string
  description = "Name of key. vault"
}
variable "exited_resource_group_name" {
  type        = string
  description = "Name of Existed resource group"
}
variable "key_vault_name_for_sql" {
  type        = string
  description = "Name of key vault sql"
}
variable "key_vault_password_for_sql" {
  type        = string
  description = "password key vault sql"
}
variable "sku_app" {
  type        = string
  description = "sku of app"
}
variable "allowed_ip_address" {
  type        = string
  description = "IP address verification"
}
variable "name_of_firewall" {
  type        = string
  description = "Name of String"
}
variable "dot_net_version" {
  type        = string
  description = "dot net version of project"
}
variable "sku_plan" {
  type        = string
  description = "name of plan"
}
