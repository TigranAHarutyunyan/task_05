variable "creator" {
  type        = string
  description = "name of creator"
}

variable "app_name" {
  type        = string
  description = "name of app "
}
variable "asp_name" {
  type        = string
  description = "name of asp"
}

variable "sql_connection_string" {
  type        = string
  description = "String of connection database"
}
variable "rg_name" {
  type        = string
  description = "name of resource group"
}
variable "dot_net_version" {
  type        = string
  description = "dot net version of project"
}
variable "region" {
  type        = string
  description = "region  of resource group"
}
variable "sku_plan" {
  type        = string
  description = "name of plan"
}