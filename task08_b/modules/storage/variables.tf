
variable "name" {
  type        = string
  description = "name of Azure  Container Registry"
}
variable "rg_name" {
  type        = string
  description = "Name of Resource group"
}
variable "location" {
  type        = string
  description = "Location"
}
variable "creator" {
  type        = string
  description = "Email of Creator"
}
variable "sa_container_name" {
  type        = string
  description = "Name of Storage conmatiner"
}
variable "account_replication_type" {
  type        = string
  description = "account replication type"
}
variable "conatiner_access_type" {
  type        = string
  description = "Acces type"
}
variable "path_tar" {
  type        = string
  description = "Path of tar.gz"
}