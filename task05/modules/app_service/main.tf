resource "azurerm_windows_web_app" "this" {
  name                = var.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  site_config {
    always_on                     = true
    ip_restriction_default_action = "Deny"
    dynamic "ip_restriction" {
      for_each = var.ip_restrictions
      iterator = rule
      content {
        name        = rule.value.name
        action      = rule.value.action
        priority    = rule.value.priority
        ip_address  = try(rule.value.ip_address, null)
        service_tag = try(rule.value.service_tag, null)
      }
    }
  }
  tags = {
    Creator = var.creator
  }
}
