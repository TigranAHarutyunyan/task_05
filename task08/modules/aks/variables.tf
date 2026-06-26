variable "pool_name" {
  type        = string
  description = "Name of Pool"
}
variable "pool_instance_count" {
  type        = number
  description = "Count of instances"
}
variable "pool_instance_node_size" {
  type        = string
  description = "Size of  instances"
}
variable "pool_disk_type" {
  type        = string
  description = "disk type "
}
variable "name" {
  type        = string
  description = "name of key vault"
}
variable "rg_name" {
  type        = string
  description = "Name od Resource group"
}
variable "location" {
  type        = string
  description = "Location"
}
variable "acr_id" {
  type        = string
  description = "ID of acr"
}
variable "key_vault_id" {
  type        = string
  description = "Id of Key vault"
}
variable "tenant_id" {
  type        = string
  description = "Tenand Id"
}
variable "creator" {
  type        = string
  description = "name of creator"
}
