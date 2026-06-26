variable "name" {
  type        = string
  description = "name of key vault"
}
variable "rg_name" {
  type        = string
  description = "name of resource group"
}
variable "location" {
  type        = string
  description = "Location"
}
variable "tenant_id" {
  type        = string
  description = "Tenand Id"
}
variable "sku_name" {
  type        = string
  description = "sku of Key vault "
}
variable "creator" {
  type        = string
  description = "name of creator"
}
variable "redis-hostname" {
  type        = string
  description = "Hostaname of redis"
}
variable "redis-primary-key" {
  type        = string
  description = "redis primary access key"
}
variable "key_vault_redis_hostname" {
  type        = string
  description = "redis hostaname"
}
variable "key_vault_redis_primary_key" {
  type        = string
  description = "name of primary key "
}
variable "sp_object_id" {
  type        = string
  description = "Object ID of the Terraform Service Principal"
}
