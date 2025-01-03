resource "azurerm_log_analytics_workspace" "log-workspace2" {
  name                = "log-analytics-workspace-test2"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

resource "azurerm_application_insights" "test-flex-ai2" {
  name                = "application-insight-test2"
  location            = var.location
  resource_group_name = var.rg_name
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.log-workspace2.id
  tags                = var.tags
}
resource "azurerm_storage_container" "main_container2" {
  name                  = "app-pakage-flexconsumption2"
  storage_account_name = var.storage_account_name
  container_access_type = "private"
}

resource "azapi_resource" "function2" {
  # schema_validation_enabled = false
  name                      = "flex-plan-function-app2"
  parent_id                 = data.azurerm_resource_group.my_rg.id
  location                  = var.location
  type                      = "Microsoft.Web/sites@2024-04-01"
  tags                      = var.tags
  body = {
    kind = "functionapp,linux"
    identity = {
      type = "UserAssigned",
      userAssignedIdentities = { "${azurerm_user_assigned_identity.user-identity.id}" : {} }
    }
    properties = {
      serverFarmId = "${var.service_plan_id}"
      httpsOnly    = true

      siteConfig = {
        appSettings = [
          {
            "name" : "DEPLOYMENT_STORAGE_CONNECTION_STRING",
            "value" : "${var.storage_account_connection_string}"
          },
          {
            "name" : "APPLICATIONINSIGHTS_CONNECTION_STRING",
            "value" : "${azurerm_application_insights.test-flex-ai2.connection_string}"
          },
          {
            "name" : "AzureWebJobsStorage",
            "value" : "${var.storage_account_connection_string}"
          }
        ],
        ipSecurityRestrictions = [
          {
            "ipAddress" : "182.76.141.104/29",
            "action" : "Allow",
            "tag" : "Default",
            "priority" : 100,
            "name" : "rule1"
          },
          {
            "ipAddress" : "115.112.142.32/29",
            "action" : "Allow",
            "tag" : "Default",
            "priority" : 101,
            "name" : "rule2"
          },
          {
            "ipAddress" : "14.97.73.248/29",
            "action" : "Allow",
            "tag" : "Default",
            "priority" : 103,
            "name" : "rule3"
          }
        ],
        scmIpSecurityRestrictions = [
          {
            "ipAddress" : "182.76.141.104/29",
            "action" : "Allow",
            "tag" : "Default",
            "priority" : 100,
            "name" : "rule1"
          },
          {
            "ipAddress" : "115.112.142.32/29",
            "action" : "Allow",
            "tag" : "Default",
            "priority" : 101,
            "name" : "rule2"
          },
          {
            "ipAddress" : "14.97.73.248/29",
            "action" : "Allow",
            "tag" : "Default",
            "priority" : 103,
            "name" : "rule3"
          }
        ],
        ipSecurityRestrictionsDefaultAction    = "Deny"
        scmIpSecurityRestrictionsDefaultAction = "Deny"
      }
      functionAppConfig = {
        deployment = {
          storage = {
            type  = "blobcontainer"
            value = "https://${var.storage_account_name}.blob.core.windows.net/${azurerm_storage_container.main_container2.name}"
            authentication = {
              type                               = "storageaccountconnectionstring"
              storageAccountConnectionStringName = "DEPLOYMENT_STORAGE_CONNECTION_STRING"
            }
          }
        }
        runtime = {
          name    = "dotnet-isolated"
          version = "8.0"
        }
        scaleAndConcurrency = {
          instanceMemoryMB     = 2048
          maximumInstanceCount = 40
        }
      }
      publicNetworkAccess                    = "Enabled"
      keyVaultReferenceIdentity = "${azurerm_user_assigned_identity.user-identity.id}"
      virtualNetworkSubnetId                 = "${azurerm_subnet.function-subnet.id}"
    }
  }
}
