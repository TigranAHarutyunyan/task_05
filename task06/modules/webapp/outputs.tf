output "app_hostname" {
  description = "Hostaname  of app"
  value       = azurerm_linux_web_app.app.default_hostname
}