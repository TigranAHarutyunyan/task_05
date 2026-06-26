output "key_vault_id" {
  value       = azurerm_key_vault.kv.id
  description = "id of Key vault"
}
output "key_vault_name" {
  value       = azurerm_key_vault.kv.name
  description = "name of Key vault"
}
output "key_vault_uri" {
  value       = azurerm_key_vault.kv.vault_uri
  description = "uri of Key vault"
}