resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location
  dns_prefix          = "company"
  default_node_pool {
    name            = var.node_pool_name
    vm_size         = var.node_pool_instance_node_size
    node_count      = 1
    os_disk_type    = var.node_pool_os_disk_type
    os_disk_size_gb = 30
  }
  identity {
    type = "SystemAssigned"
  }
  tags = {
    Creator = var.creator
  }
  key_vault_secrets_provider {
    secret_rotation_enabled  = true
    secret_rotation_interval = "2m"
  }
  oidc_issuer_enabled = true
}


resource "azurerm_key_vault_access_policy" "aks-kv" {
  key_vault_id = var.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].object_id
  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete"
  ]
}

resource "azurerm_role_assignment" "aks-pull" {
  scope                = var.scope
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
}