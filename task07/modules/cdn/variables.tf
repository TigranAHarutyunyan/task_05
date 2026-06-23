variable "rg_name" {
  type        = string
  description = "Name of Resource group"
}
variable "endpoint_name" {
  type        = string
  description = "Name of Endpoint"
}
variable "location" {
  type        = string
  description = "Location"
}
variable "profiler_name" {
  type        = string
  description = "Name of Profile"
}
variable "sku_name" {
  type        = string
  description = "Sku of Front Door"
}
variable "og_name" {
  type        = string
  description = "Name of Origin group"
}
variable "route_name" {
  type        = string
  description = "Name of route"
}
variable "origin_name" {
  type        = string
  description = "Name of Origin"
}
variable "host_name" {
  type        = string
  description = "Hostname of origin"
}
variable "origin_host_header" {
  type        = string
  description = "Origin host header"
}
variable "cdn_origin_path" {
  type        = string
  description = "The blob  container path to use as CDN origin path"
}