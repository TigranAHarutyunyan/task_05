resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = "company"
  default_node_pool {
    name            = var.pool_name
    node_count      = var.pool_instance_count
    vm_size         = var.pool_instance_node_size
    os_disk_type    = var.pool_disk_type
    os_disk_size_gb = 100
  }
  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }
  identity {
    type = "SystemAssigned"
  }
  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  tags = {
    Creator = var.creator
  }
}
resource "azurerm_role_assignment" "acr_pull" {
  scope                = var.acr_id
  role_definition_name = "ACRpull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

resource "azurerm_key_vault_access_policy" "name" {
  key_vault_id       = var.key_vault_id
  object_id          = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].object_id
  secret_permissions = ["Get", "List"]
  tenant_id          = var.tenant_id
}