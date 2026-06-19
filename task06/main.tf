provider "azurerm" {
  features {}

}
resource "random_string" "sql_admin_username" {
  length  = 12
  special = false
  upper   = false
}

resource "random_password" "sql_admin_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}


data "azurerm_client_config" "current" {}
data "azurerm_key_vault" "existing_kv" {
  name                = var.existed_key_vault_name
  resource_group_name = var.exited_resource_group_name

}
resource "azurerm_key_vault_secret" "sql_admin_username" {
  name         = var.key_vault_name_for_sql
  value        = random_string.sql_admin_username.result
  key_vault_id = data.azurerm_key_vault.existing_kv.id
}
resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = var.key_vault_password_for_sql
  value        = random_password.sql_admin_password.result
  key_vault_id = data.azurerm_key_vault.existing_kv.id
}
resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.region

  tags = {
    Creator = local.creator
  }
}

module "sql" {
  source                 = "./modules/sql"
  creator                = local.creator
  server_name            = local.sql_server_name
  db_name                = local.sql_db_name
  administrator_login    = random_string.sql_admin_username.result
  administrator_password = random_password.sql_admin_password.result
  region                 = azurerm_resource_group.rg.location
  tenant_id              = data.azurerm_client_config.current.tenant_id
  rg_name                = azurerm_resource_group.rg.name
  name_of_firewall       = var.name_of_firewall
  allowed_ip_address     = var.allowed_ip_address
}

module "webapp" {
  source                = "./modules/webapp"
  creator               = local.creator
  app_name              = local.app_name
  asp_name              = local.asp_name
  sql_connection_string = module.sql.sql_connection_string
  rg_name               = azurerm_resource_group.rg.name
  region                = azurerm_resource_group.rg.location
  dot_net_version       = var.dot_net_version

  sku_plan = var.sku_plan
}
