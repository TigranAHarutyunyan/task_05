
locals {
  creator = var.creator

  name_pattern_rg         = compact([var.project, var.env_name, var.module_name, "rg"])
  rg_name                 = join("-", local.name_pattern_rg)
  name_pattern_sql_server = compact([var.project, var.env_name, var.module_name, "sql"])
  sql_server_name         = join("-", local.name_pattern_sql_server)
  sql_db_name             = format("%s-%s-%s-sql-db", var.project, var.env_name, var.module_name)
  asp_name                = format("%s-%s-%s-asp", var.project, var.env_name, var.module_name)
  app_name                = format("%s-%s-%s-app", var.project, var.env_name, var.module_name)
}
