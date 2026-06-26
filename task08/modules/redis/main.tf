resource "azurerm_redis_cache" "redis" {
  name                 = var.name
  resource_group_name  = var.rg_name
  location             = var.location
  capacity             = var.capacity
  family               = var.family
  sku_name             = var.sku
  non_ssl_port_enabled = false
  minimum_tls_version  = "1.2"
  tags = {
    Creator = var.creator
  }

}