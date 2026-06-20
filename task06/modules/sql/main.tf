resource "azurerm_mssql_server" "sql_server" {
  name                         = var.server_name
  resource_group_name          = var.rg_name
  location                     = var.region
  version                      = "12.0"
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_password
  tags = {
    Creator = var.creator
  }
}
resource "azurerm_mssql_database" "sql_database" {
  name      = var.db_name
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = "S2"

  tags = {
    Creator = var.creator
  }
}
resource "azurerm_mssql_firewall_rule" "allowed_ip_address" {
  name             = var.name_of_firewall
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = var.allowed_ip_address
  end_ip_address   = var.allowed_ip_address
}
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}