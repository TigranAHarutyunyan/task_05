output "id" {
  value       = azurerm_kubernetes_cluster.aks.id
  description = "AKS cluster resource ID"
}

output "host" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].host
  sensitive   = true
  description = "AKS Kubernetes API server host"
}

output "client_certificate" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive   = true
  description = "AKS client certificate"
}

output "client_key" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
  sensitive   = true
  description = "AKS client key"
}

output "cluster_ca_certificate" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  sensitive   = true
  description = "AKS cluster CA certificate"
}

output "key_vault_secrets_provider_client_id" {
  value       = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].client_id
  description = "Client ID of the AKS Key Vault Secrets Provider identity"
}
