resource "azurerm_container_registry" "acr" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = true
  tags = {
    Creator = var.creator
  }
}

resource "azurerm_container_registry_task" "acr_task" {
  name                  = "build"
  container_registry_id = azurerm_container_registry.acr.id
  platform {
    os = "Linux"
  }
  docker_step {
    dockerfile_path      = var.dockerfile_path
    context_path         = var.context_path
    image_names          = ["${azurerm_container_registry.acr.login_server}/${var.docker_image_name}:latest"]
    context_access_token = var.git_pat
  }
}

resource "azurerm_container_registry_task_schedule_run_now" "run_now" {
  container_registry_task_id = azurerm_container_registry_task.acr_task.id
}