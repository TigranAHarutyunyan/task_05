variable "file_name_storage" {
  type        = string
  description = "Name of file in the Storage account"
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
variable "group" {
  type        = string
  description = "name of group"
}
variable "location" {
  type        = string
  description = "Location"
}
variable "fw_sku_name" {
  type        = string
  description = "sku of profile"
}
variable "fw_route_name" {
  type        = string
  description = "route name"
}
