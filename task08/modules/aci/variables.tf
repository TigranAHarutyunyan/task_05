variable "sku" {
  type        = string
  description = "type of acr"
}
variable "creator" {
  type        = string
  description = "name of creator"
}
variable "name" {
  type        = string
  description = "Name of Redis Cache"
}
variable "rg_name" {
  type        = string
  description = "Name od Resource group"
}
variable "location" {
  type        = string
  description = "Location"
}
variable "docker_image_name" {
  type        = string
  description = "Docker image name"
}
variable "admin_username" {
  type        = string
  description = ""
}
variable "login_server" {
  type        = string
  description = "Login Server "
}
variable "admin_password" {
  type        = string
  description = "password of ACI"
}
variable "redis-hostname" {
  type        = string
  description = "Hostaname of redis"
}
variable "redis-primary-key" {
  type        = string
  description = "redis primary access key"
}