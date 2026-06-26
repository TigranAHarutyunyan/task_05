provider "azurerm" {
  features {}
}
provider "kubernetes" {
  host                   = module.aks.kube_config[0].host
  client_certificate     = base64decode(module.aks.kube_config[0].client_certificate)
  client_key             = base64decode(module.aks.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(module.aks.kube_config[0].cluster_ca_certificate)
}
provider "kubectl" {
  host                   = module.aks.kube_config[0].host
  client_certificate     = base64decode(module.aks.kube_config[0].client_certificate)
  client_key             = base64decode(module.aks.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(module.aks.kube_config[0].cluster_ca_certificate)
  load_config_file       = false
}
resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags = {
    Creator = var.creator
  }
}

data "kubernetes_service_v1" "app" {
  metadata {
    name      = "redis-flask-app-service"
    namespace = "default"
  }
  depends_on = [kubectl_manifest.app_service]
}
resource "kubectl_manifest" "app_deployment" {
  yaml_body = templatefile("${path.module}/k8-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.login_server
    app_image_name   = local.docker_image
    image_tag        = "latest"
  })

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }

  depends_on = [kubectl_manifest.secret_provider]
}
resource "kubectl_manifest" "app_service" {
  yaml_body = file("${path.module}/k8-manifests/service.yaml")

  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }
}



resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.user_assigned_identity_id
    kv_name                    = module.keyvault.key_vault_name
    redis_url_secret_name      = var.key_vault_redis_hostname
    redis_password_secret_name = var.key_vault_redis_primary_key
    tenant_id                  = data.azurerm_client_config.current.tenant_id
  })
}


module "aci" {
  source            = "./modules/aci"
  name              = local.aci_name
  location          = azurerm_resource_group.rg.location
  rg_name           = azurerm_resource_group.rg.name
  sku               = var.aci_sku
  creator           = var.creator
  login_server      = module.acr.login_server
  admin_username    = module.acr.admin_username
  admin_password    = module.acr.admin_password
  docker_image_name = local.docker_image
  redis-hostname    = module.redis.redis_hostname
  redis-primary-key = module.redis.redis_primary_key

  depends_on = [module.acr]
}
module "acr" {
  source            = "./modules/acr"
  name              = local.acr_name
  rg_name           = azurerm_resource_group.rg.name
  location          = azurerm_resource_group.rg.location
  sku               = var.acr_sku
  creator           = var.creator
  docker_image_name = local.docker_image
  git_pat           = var.git_pat
  dockerfile_path   = var.dockerfile_path
  context_path      = var.context_path
}
module "aks" {
  source                  = "./modules/aks"
  pool_name               = var.pool_name
  pool_instance_node_size = var.pool_instance_node_size
  pool_instance_count     = var.pool_instance_count
  pool_disk_type          = var.pool_disk_type
  name                    = local.aks_name
  rg_name                 = azurerm_resource_group.rg.name
  location                = azurerm_resource_group.rg.location
  acr_id                  = module.acr.acr_id
  key_vault_id            = module.keyvault.key_vault_id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  creator                 = var.creator

  depends_on = [module.keyvault]
}
data "azurerm_client_config" "current" {}
module "keyvault" {
  source                      = "./modules/keyvault"
  name                        = local.keyvault_name
  location                    = azurerm_resource_group.rg.location
  rg_name                     = azurerm_resource_group.rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sp_object_id                = data.azurerm_client_config.current.object_id
  sku_name                    = var.key_vault_sku
  creator                     = var.creator
  redis-hostname              = module.redis.redis_hostname
  redis-primary-key           = module.redis.redis_primary_key
  key_vault_redis_hostname    = var.key_vault_redis_hostname
  key_vault_redis_primary_key = var.key_vault_redis_primary_key
}
module "redis" {
  source   = "./modules/redis"
  name     = local.redis_name
  rg_name  = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  capacity = var.arcs_capacity
  sku      = var.arcs_sku
  family   = var.arcs_sku_family
  creator  = var.creator
}
