resource "azurerm_log_analytics_workspace" "law" {
  resource_group_name = var.rg_name
  name                = var.log_analytics_name
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = 30

}
resource "azurerm_container_app_environment" "aca-env" {
  name                       = var.name_env
  resource_group_name        = var.rg_name
  location                   = var.location
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  workload_profile {
    workload_profile_type = var.workload_profile_type
    name                  = var.workload_profile_type
  }
}

resource "azurerm_container_app" "aca" {
  name                         = var.aca_name
  resource_group_name          = var.rg_name
  container_app_environment_id = azurerm_container_app_environment.aca-env.id
  revision_mode                = "Single"
  secret {
    name  = "redis-url"
    value = data.azurerm_key_vault_secret.redis-hostname.value
  }
  secret {
    name  = "redis-key"
    value = data.azurerm_key_vault_secret.redis-password.value
  }
  ingress {
    external_enabled = true
    target_port      = 8080

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
  template {
    container {
      name   = "web-app"
      image  = "${var.aca-login-server}/${var.image_name}"
      cpu    = 1
      memory = "2.0Gi"
      env {
        name  = "CREATOR"
        value = "ACA"
      }
      env {
        name  = "REDIS_PORT"
        value = "6379"
      }
      env {
        name        = "REDIS_URL"
        secret_name = "redis-url"
      }
      env {
        name        = "REDIS_PWD"
        secret_name = "redis-key"
      }
    }
  }
  registry {
    server   = var.aca-login-server
    identity = azurerm_user_assigned_identity.aca-identity.id
  }
  depends_on = [azurerm_role_assignment.aca-pull]
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aca-identity.id]
  }
}

resource "azurerm_user_assigned_identity" "aca-identity" {
  name                = var.user_identity_name
  location            = var.location
  resource_group_name = var.rg_name
}
resource "azurerm_key_vault_access_policy" "kv-policy" {
  tenant_id    = var.tenant_id
  key_vault_id = var.key_vault_id
  object_id    = azurerm_user_assigned_identity.aca-identity.principal_id

  secret_permissions = [
    "Get",
    "List",
    "Delete",
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
data "azurerm_key_vault_secret" "redis-hostname" {
  name         = var.redis-hostname
  key_vault_id = var.key_vault_id
}
data "azurerm_key_vault_secret" "redis-password" {
  name         = var.redis-password
  key_vault_id = var.key_vault_id
}
resource "azurerm_role_assignment" "aca-pull" {
  scope                            = var.scope
  principal_id                     = azurerm_user_assigned_identity.aca-identity.principal_id
  role_definition_name             = "AcrPull"
  skip_service_principal_aad_check = true
}