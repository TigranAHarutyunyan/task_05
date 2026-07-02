resource "azurerm_key_vault" "kv" {
  name                      = var.name
  resource_group_name       = var.rg_name
  location                  = var.location
  tenant_id                 = var.tenant_id
  sku_name                  = var.sku
  enable_rbac_authorization = false
  tags = {
    Creator = var.creator
  }
}

resource "azurerm_key_vault_access_policy" "kv-access-policy" {
  tenant_id    = var.tenant_id
  key_vault_id = azurerm_key_vault.kv.id
  object_id    = var.object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Purge"
  ]
  key_permissions = [
    "Get",
    "List",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "Purge"
  ]
}
