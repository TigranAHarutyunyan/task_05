provider "azurerm" {
  features {}
}

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
