output "aks_id" {
  value       = azurerm_kubernetes_cluster.aks.id
  description = "Id of AKS"
}
output "aks_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "Name of aks"
}
output "kubelet_identity" {
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  description = "Kubelet Id"
}
output "kube_config" {
  value       = azurerm_kubernetes_cluster.aks.kube_config
  sensitive   = true
  description = "Config of  connection"
}
output "user_assigned_identity_id" {
  value       = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].client_id
  description = "Client ID of the Key Vault secrets provider identity"
}