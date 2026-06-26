locals {
  name_pattern_rg           = compact([var.project, var.env_name, var.module_name, "rg"])
  rg_name                   = join("-", local.name_pattern_rg)
  name_pattern_aci          = compact([var.project, var.env_name, var.module_name, "ci"])
  aci_name                  = join("-", local.name_pattern_aci)
  name_pattern_acr          = compact([var.project, var.env_name, var.module_name, "cr"])
  acr_name                  = join("", local.name_pattern_acr)
  name_pattern_aks          = compact([var.project, var.env_name, var.module_name])
  aks_name                  = join("-", local.name_pattern_aks)
  name_pattern_kv           = compact([var.project, var.env_name, var.module_name, "kv"])
  keyvault_name             = join("-", local.name_pattern_kv)
  name_pattern_redis        = compact([var.project, var.env_name, var.module_name, "redis"])
  redis_name                = join("-", local.name_pattern_redis)
  name_pattern_docker_image = compact([var.project, var.env_name, var.module_name, "app"])
  docker_image              = join("-", local.name_pattern_docker_image)

}
