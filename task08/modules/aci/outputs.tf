output "aci_id" {
  value       = azurerm_container_group.aci.id
  description = "ACI ID"
}
output "aci_fqdn" {
  value       = azurerm_container_group.aci.fqdn
  description = "ACI FQDN"
}