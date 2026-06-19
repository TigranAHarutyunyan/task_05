output "sql_server_fqdn" {
  description = "FQDN of  sql server"
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}
output "sql_connection_string" {
  description = "SQL conection srring"
  value       = "Server=tcp:${azurerm_mssql_server.sql_server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.sql_database.name};Persist Security Info=False;User ID=${var.administrator_login};Password=${var.administrator_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  sensitive   = true
}