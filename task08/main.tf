provider "azurerm" {
  features {}
}

provider "azapi" {}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags = {
    Creator = var.creator
  }
}

data "azurerm_client_config" "current" {}

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

module "aks" {
  source                  = "./modules/aks"
  name                    = local.aks_name
  location                = azurerm_resource_group.rg.location
  rg_name                 = azurerm_resource_group.rg.name
  pool_name               = var.pool_name
  pool_instance_count     = var.pool_instance_count
  pool_instance_node_size = var.pool_instance_node_size
  pool_disk_type          = var.pool_disk_type
  creator                 = var.creator
  acr_id                  = module.acr.acr_id
  key_vault_id            = module.keyvault.key_vault_id
  tenant_id               = data.azurerm_client_config.current.tenant_id
}

locals {
  secret_provider_manifest = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.key_vault_secrets_provider_client_id
    kv_name                    = module.keyvault.key_vault_name
    redis_url_secret_name      = var.key_vault_redis_hostname
    redis_password_secret_name = var.key_vault_redis_primary_key
    tenant_id                  = data.azurerm_client_config.current.tenant_id
  })

  deployment_manifest = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.login_server
    app_image_name   = local.docker_image
    image_tag        = "latest"
  })

  service_manifest = file("${path.module}/k8s-manifests/service.yaml")

  apply_k8s_manifests_command = <<-EOT
set -e

for i in $(seq 1 60); do
  if kubectl get crd secretproviderclasses.secrets-store.csi.x-k8s.io >/dev/null 2>&1; then
    break
  fi
  sleep 10
done

kubectl get crd secretproviderclasses.secrets-store.csi.x-k8s.io

printf '%s' '${base64encode(local.secret_provider_manifest)}' | base64 -d | kubectl apply -n default -f -
printf '%s' '${base64encode(local.deployment_manifest)}' | base64 -d | kubectl apply -n default -f -
printf '%s' '${base64encode(local.service_manifest)}' | base64 -d | kubectl apply -n default -f -

kubectl rollout status deployment/redis-flask-app -n default --timeout=10m

for i in $(seq 1 60); do
  ip=$(kubectl get service redis-flask-app-service -n default -o jsonpath='{.status.loadBalancer.ingress[0].ip}' 2>/dev/null)
  if [ -n "$ip" ]; then
    echo "$ip"
    exit 0
  fi
  sleep 10
done

kubectl get service redis-flask-app-service -n default
exit 1
EOT

  aks_manifest_apply_logs = try(
    azapi_resource_action.apply_k8s_manifests.output.properties.logs,
    jsondecode(azapi_resource_action.apply_k8s_manifests.output).properties.logs,
    ""
  )
}

resource "azapi_resource_action" "apply_k8s_manifests" {
  type        = "Microsoft.ContainerService/managedClusters@2024-05-01"
  resource_id = module.aks.id
  action      = "runCommand"
  method      = "POST"

  body = {
    command = local.apply_k8s_manifests_command
    context = ""
  }

  response_export_values = ["*"]

  depends_on = [module.aks]
}
