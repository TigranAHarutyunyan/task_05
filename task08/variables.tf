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
variable "creator" {
  type        = string
  description = "name of creator"
}
variable "aci_sku" {
  type        = string
  description = "Sku of aci"
}
variable "arcs_capacity" {
  type        = number
  description = "Capacity of Azure Redis Cache Service"
}
variable "arcs_sku" {
  type        = string
  description = "Sku of Azure Redis Cache Service"
}
variable "arcs_sku_family" {
  type        = string
  description = "Family of sku arcs"
}
variable "location" {
  type        = string
  description = "Location "
}
variable "key_vault_sku" {
  type        = string
  description = "sku of Key vault "
}
variable "key_vault_redis_hostname" {
  type        = string
  description = "redis hostaname"
}
variable "key_vault_redis_primary_key" {
  type        = string
  description = "name of primary key "
}
variable "acr_sku" {
  type        = string
  description = "type of acr"
}
variable "git_pat" {
  type        = string
  sensitive   = true
  description = "Git access token"
}
variable "dockerfile_path" {
  type        = string
  description = "Path of Dockerfile"
}
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
variable "context_path" {
  type        = string
  description = "Path to the Source code "
}