output "sql_server_fqdn" {
  value       = module.sql.sql_server_fqdn
  description = "fdqn sql server"
}

output "app_hostname" {
  value       = module.webapp.app_hostname
  description = "hostaname of app"
}