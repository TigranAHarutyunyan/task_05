resource "random_password" "redis-password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}


resource "azurerm_container_group" "acg" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = var.sku
  os_type             = "Linux"
  dns_name_label      = "redis-db"
  container {
    name   = "redis-container"
    image  = "${var.login-server}/redis:7-alpine"
    cpu    = 1
    memory = 1.5
    commands = [
      "redis-server",
      "--protected-mode no --requirepass",
      random_password.redis-password.result
    ]
    ports {
      port     = 6379
      protocol = "TCP"
    }
  }
}

resource "azurerm_key_vault_secret" "redis-password" {
  key_vault_id = var.key_vault_id
  value        = random_password.redis-password.result
  name         = var.redis-password
}

resource "azurerm_key_vault_secret" "redis-hostname" {
  key_vault_id = var.key_vault_id
  value        = azurerm_container_group.acg.fqdn
  name         = var.redis-hostname
}