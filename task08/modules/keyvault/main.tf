resource "azurerm_key_vault" "kv" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location
  tenant_id           = var.tenant_id
  sku_name            = var.sku_name
  tags = {
    Creator = var.creator
  }
}
resource "azurerm_key_vault_secret" "redis-hostname" {
  name         = var.key_vault_redis_hostname
  key_vault_id = azurerm_key_vault.kv.id
  value        = var.redis-hostname

  depends_on = [azurerm_key_vault_access_policy.terraform_sp]
}
resource "azurerm_key_vault_secret" "redis-primary-key" {
  name         = var.key_vault_redis_primary_key
  key_vault_id = azurerm_key_vault.kv.id
  value        = var.redis-primary-key

  depends_on = [azurerm_key_vault_access_policy.terraform_sp]
}

resource "azurerm_key_vault_access_policy" "terraform_sp" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = var.tenant_id
  object_id    = var.sp_object_id

  secret_permissions = ["Get", "List", "Set", "Delete", "Recover", "Purge"]
}