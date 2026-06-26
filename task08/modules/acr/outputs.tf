output "login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "Login server for ACR"
}
output "admin_username" {
  value       = azurerm_container_registry.acr.admin_username
  description = "Username of ACR"
}
output "admin_password" {
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true
  description = "password of ACR"
}
output "acr_id" {
  value       = azurerm_container_registry.acr.id
  description = "Id of azure conatiner resource"
}
