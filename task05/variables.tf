variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
  }))
  description = "A map of resource group objects"
}

variable "asp" {
  type = map(object({
    name           = string
    location       = string
    resource_group = string
    worker_count   = number
    sku            = string
    os_type        = string
  }))
  description = "A map of App Service Plan objects"
}

variable "app" {
  type = map(object({
    name                    = string
    location                = string
    resource_group          = string
    service_plan            = string
    allow_IP_rule_name      = string
    Verification_IP_address = string
  }))
  description = "A map of App Service objects"
}

variable "tm" {
  type = object({
    name                   = string
    traffic_routing_method = string
  })
  description = "Traffic Manager config"
}

variable "creator" {
  description = "Name of Creator"
  type        = string
}
variable "endpoint" {
  description = "Name of Endpoint"
  type        = string
}
variable "allow_tm_rule_name" {
  description = "name of rule "
  type        = string
}