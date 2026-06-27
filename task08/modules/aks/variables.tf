variable "name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "location" {
  type        = string
  description = "Azure region for the AKS cluster"
}

variable "rg_name" {
  type        = string
  description = "Resource group name for the AKS cluster"
}

variable "pool_name" {
  type        = string
  description = "Name of the default AKS node pool"
}

variable "pool_instance_count" {
  type        = number
  description = "Number of nodes in the default AKS node pool"
}

variable "pool_instance_node_size" {
  type        = string
  description = "VM size for the default AKS node pool"
}

variable "pool_disk_type" {
  type        = string
  description = "OS disk type for the default AKS node pool"
}

variable "creator" {
  type        = string
  description = "Creator tag value"
}

variable "acr_id" {
  type        = string
  description = "Azure Container Registry resource ID"
}

variable "key_vault_id" {
  type        = string
  description = "Key Vault resource ID"
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID"
}
