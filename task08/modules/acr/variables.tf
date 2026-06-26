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
variable "git_pat" {
  type        = string
  description = "Git access token"
}
variable "dockerfile_path" {
  type        = string
  description = "Path of Dockerfile"
}
variable "context_path" {
  type        = string
  description = "Path to the Source code "
}