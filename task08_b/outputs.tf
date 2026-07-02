output "aca_fqdn" {
  value       = module.aca.aca_fqdn
  description = "FQND of ACA"
}
output "redis_fqdn" {
  value       = module.aci-redis.redis_fqdn
  description = "FDQN of redis "
}
output "aks_lb_ip" {
  value       = module.k8s.aks_lb_ip
  description = "Load Balancer IP address"
}
