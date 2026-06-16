provider "azurerm" {
  features {}
}

module "resource_groups" {
  source   = "./modules/resource_group"
  for_each = var.resource_groups

  name     = each.value.name
  location = each.value.location
  creator  = var.creator
}

module "asp" {
  source   = "./modules/app_service_plan"
  for_each = var.asp

  name                = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group].name
  location            = each.value.location
  sku                 = each.value.sku
  os_type             = each.value.os_type
  worker_count        = each.value.worker_count
  creator             = var.creator
}

module "webapp" {
  source   = "./modules/app_service"
  for_each = var.app

  app_name            = each.value.name
  location            = each.value.location
  resource_group_name = module.resource_groups[each.value.resource_group].name
  service_plan_id     = module.asp[each.value.service_plan].service_plan_id
  creator             = var.creator
  ip_restrictions = [
    {
      name       = each.value.allow_IP_rule_name
      action     = "Allow"
      priority   = 100
      ip_address = each.value.Verification_IP_address
    },
    {
      name        = var.allow_tm_rule_name
      action      = "Allow"
      priority    = 101
      service_tag = "AzureTrafficManager"
    }
  ]
}
module "tm" {
  source                 = "./modules/traffic_manager"
  name                   = var.tm.name
  creator                = var.creator
  resource_group_name    = module.resource_groups["rg3"].name
  traffic_routing_method = var.tm.traffic_routing_method
  endpoint_name          = var.endpoint
  target_resource_id     = [for k in keys(var.app) : module.webapp[k].id]
}
