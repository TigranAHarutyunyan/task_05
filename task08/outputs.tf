output "aci_fqdn" {
  value       = module.aci.aci_fqdn
  description = "FQDN of App in Azure Container Instance"
}

output "aks_lb_ip" {
  value       = module.aks.aks_lb_ip
  description = "IP of the Load Balancer"
}
