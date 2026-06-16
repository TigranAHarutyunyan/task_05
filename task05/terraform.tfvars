resource_groups = {
  rg1 = {
    name     = "cmaz-j5tku7ra-mod5-rg-01"
    location = "West Europe"
  }
  rg2 = {
    name     = "cmaz-j5tku7ra-mod5-rg-02"
    location = "North Europe"
  }
  rg3 = {
    name     = "cmaz-j5tku7ra-mod5-rg-03"
    location = "East US"
  }
}

asp = {
  asp1 = {
    name           = "cmaz-j5tku7ra-mod5-asp-01"
    location       = "West Europe"
    resource_group = "rg1"
    worker_count   = 2
    sku            = "S1"
    os_type        = "Windows"
  }
  asp2 = {
    name           = "cmaz-j5tku7ra-mod5-asp-02"
    location       = "North Europe"
    resource_group = "rg2"
    worker_count   = 1
    sku            = "S1"
    os_type        = "Windows"
  }
}

app = {
  app1 = {
    name                    = "cmaz-j5tku7ra-mod5-app-01"
    location                = "West Europe"
    resource_group          = "rg1"
    service_plan            = "asp1"
    allow_IP_rule_name      = "allow-ip"
    Verification_IP_address = "18.153.146.156/32"
  }
  app2 = {
    name                    = "cmaz-j5tku7ra-mod5-app-02"
    location                = "North Europe"
    resource_group          = "rg2"
    service_plan            = "asp2"
    allow_IP_rule_name      = "allow-ip"
    Verification_IP_address = "18.153.146.156/32"
  }
}
tm = {
  name                   = "cmaz-j5tku7ra-mod5-traf"
  traffic_routing_method = "Performance"
}
endpoint           = "tm-app"
allow_tm_rule_name = "allow-tm"

creator = "tigran_harutyunyan@epam.com"
