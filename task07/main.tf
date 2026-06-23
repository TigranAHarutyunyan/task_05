provider "azurerm" {
  features {}

}
resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
}

resource "azurerm_storage_account" "sa" {
  name                             = local.sa_name
  location                         = var.location
  resource_group_name              = azurerm_resource_group.rg.name
  account_tier                     = "Standard"
  account_replication_type         = "LRS"
  min_tls_version                  = "TLS1_2"
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false

}

import {
  to = azurerm_resource_group.rg
  id = var.sub_id
}
import {
  to = azurerm_storage_account.sa
  id = var.storage_id
}
module "cdn" {
  source             = "./modules/cdn"
  rg_name            = azurerm_resource_group.rg.name
  host_name          = azurerm_storage_account.sa.primary_blob_host
  origin_host_header = azurerm_storage_account.sa.primary_blob_host

  endpoint_name = local.cdn_endpoint_name
  location      = azurerm_resource_group.rg.location
  og_name       = local.cdn_origin_group_name
  profiler_name = local.cdn_profile_name
  sku_name      = var.fw_sku_name
  route_name    = var.fw_route_name
  origin_name   = local.cdn_origin_name

}