output "aks_lb_ip" {
  value       = data.kubernetes_service_v1.app.status[0].load_balancer[0].ingress[0].ip
  description = "IP of the Load Balancer"
}
output "aci_fqdn" {
  value       = module.aci.aci_fqdn
  description = "FQDN of App in Azure Container Instance"
}