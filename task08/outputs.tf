output "aci_fqdn" {
  value       = module.aci.aci_fqdn
  description = "FQDN of App in Azure Container Instance"
}

output "aks_lb_ip" {
  value       = try(regex("[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+", local.aks_manifest_apply_logs), "")
  description = "IP of the Load Balancer"
}
