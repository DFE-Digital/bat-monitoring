resource "azapi_resource" "aca_env" {
  type      = "Microsoft.App/managedEnvironments@2022-06-01-preview"
  parent_id = azurerm_resource_group.app_group.id
  location  = azurerm_resource_group.app_group.location
  name      = var.aca_environment_name
  tags      = data.azurerm_resource_group.backend_resource_group_name.tags

  body = jsonencode({
    properties = {
      appLogsConfiguration = {
        destination = "log-analytics"
        logAnalyticsConfiguration = {
          customerId = azurerm_log_analytics_workspace.law.workspace_id
          sharedKey  = azurerm_log_analytics_workspace.law.primary_shared_key
        }
      }
    }
  })
}

resource "azapi_resource" "aca" {
  for_each  = { for ca in var.container_apps : ca.name => ca }
  type      = "Microsoft.App/containerApps@2022-06-01-preview"
  parent_id = azurerm_resource_group.app_group.id
  location  = azurerm_resource_group.app_group.location
  name      = each.value.name

  body = jsonencode({
    properties : {
      managedEnvironmentId = azapi_resource.aca_env.id
      configuration = {
        ingress = {
          external   = each.value.ingress_enabled
          targetPort = each.value.ingress_enabled ? each.value.containerPort : null
        }
        secrets = try(each.value.secrets, [])
      }
      template = {
        containers = [
          {
            name  = "main"
            image = "${each.value.image}:${each.value.tag}"
            resources = {
              cpu    = each.value.cpu_requests
              memory = each.value.mem_requests
            }
            env = try(each.value.env_vars, [])
          }
        ]
        scale = {
          minReplicas = each.value.min_replicas
          maxReplicas = each.value.max_replicas
        }
      }
    }
  })

  tags = data.azurerm_resource_group.backend_resource_group_name.tags
}