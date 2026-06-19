output "tenant_id" {
  value       = data.azurerm_client_config.current.tenant_id
  description = "Tenat Id "
}
output "sql_server_fqdn" {
  value = module.sql.sql_server_fqdn
}

output "app_hostname" {
  value = module.webapp.app_hostname
}