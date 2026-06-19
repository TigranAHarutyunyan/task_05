resource "azurerm_service_plan" "asp" {
  name                = var.asp_name
  resource_group_name = var.rg_name
  location            = var.region
  os_type             = "Linux"
  sku_name            = var.sku_plan
  tags = {
    Creator = var.creator
  }
}
resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  resource_group_name = var.rg_name
  location            = var.region
  service_plan_id     = azurerm_service_plan.asp.id
  site_config {
    application_stack {
      dotnet_version = var.dot_net_version
    }
  }
  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "true"
  }
  connection_string {
    name  = "DefaultConnection"
    type  = "SQLAzure"
    value = var.sql_connection_string
  }
  tags = {
    Creator = var.creator
  }
}
