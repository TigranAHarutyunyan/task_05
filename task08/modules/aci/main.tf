resource "azurerm_container_group" "aci" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location
  ip_address_type     = "Public"
  dns_name_label      = "az-cours-webapp-21"
  os_type             = "Linux"
  container {
    name   = var.docker_image_name
    image  = "${var.login_server}/${var.docker_image_name}:latest"
    cpu    = 1
    memory = 1.5
    environment_variables = {
      CREATOR        = "ACI"
      REDIS_PORT     = "6380"
      REDIS_SSL_MODE = "True"
    }
    secure_environment_variables = {
      REDIS_URL = var.redis-hostname
      REDIS_PWD = var.redis-primary-key
    }
    ports {
      port     = 80
      protocol = "TCP"
    }
  }
  image_registry_credential {
    server   = var.login_server
    username = var.admin_username
    password = var.admin_password
  }

  tags = {
    Creator = var.creator
  }
}