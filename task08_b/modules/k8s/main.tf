data "azurerm_key_vault_secret" "hostname" {
  key_vault_id = var.key_vault_id
  name         = var.redis-hostname
}

data "azurerm_key_vault_secret" "password" {
  key_vault_id = var.key_vault_id
  name         = var.redis-password
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${var.manifests_path}/deployment.yaml.tftpl", {
    acr_login_server = var.acr_login_server
    app_image_name   = var.image_name
    image_tag        = "latest"
  })

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }
  depends_on = [kubectl_manifest.secret-provider]
}
resource "kubectl_manifest" "secret-provider" {
  yaml_body = templatefile("${var.manifests_path}/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = var.aks_kv_access_identity_client_id
    tenant_id                  = var.tenant_id
    kv_name                    = var.kv-name
    redis_url_secret_name      = data.azurerm_key_vault_secret.hostname.value
    redis_password_secret_name = data.azurerm_key_vault_secret.password.value
  })
    depends_on = [kubectl_manifest.service]
}
resource "kubectl_manifest" "service" {
  yaml_body = file("${var.manifests_path}/service.yaml")
  wait_for {
    field {
      key        = "status.loadBalancer.ingress.0.ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }
}
data "kubernetes_service_v1" "app" {
  metadata {
    name      = "redis-flask-app-service"
    namespace = "default"
  }
  depends_on = [
    kubectl_manifest.service
  ]
}


