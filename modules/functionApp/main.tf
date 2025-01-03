# resource "azurerm_linux_function_app" "my_functionApp" {
#   name                = var.name
#   resource_group_name = var.rg_name
#   location            = var.location

#   storage_account_name       = var.storage_account_name
#   storage_account_access_key = var.storage_account_access_key
#   service_plan_id            = var.service_plan_id
#   tags = var.tags

#   site_config {
#     app_scale_limit = 100
#     # application_stack {
#     #   dotnet_version = "8.0"
#     # }
#   }
  
#   app_settings = {
#     "DEPLOYMENT_STORAGE_CONNECTION_STRING": "DefaultEndpointsProtocol=https;AccountName=${var.storage_account_name};AccountKey=${var.storage_account_access_key};EndpointSuffix=core.windows.net"
#   }

  # connection_string {
  #   name = "DEPLOYMENT_STORAGE_CONNECTION_STRING"
  #   type = "Custom"
  #   value = "DefaultEndpointsProtocol=https;AccountName=${var.storage_account_name};AccountKey=${var.storage_account_access_key};EndpointSuffix=core.windows.net"
  # }

#   storage_account {
#     name = var.storage_account_name
#     account_name = var.storage_account_name
#     access_key = var.storage_account_access_key
#     type = "AzureBlob"
#     share_name = var.storage_blob_name
#   }
# }







# terraform {
#   required_providers {
#     azapi = {
#       source = "azure/azapi"
#     }
#   }
# }
# provider "azapi" {
#   skip_provider_registration = true
#   disable_default_output = true
# }

terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "2.1.0"
    }
  }
}

provider "azapi" {
  disable_default_output = true
  skip_provider_registration = true
}

data "azurerm_resource_group" "my_rg" {
  name = var.rg_name
}

resource "azurerm_user_assigned_identity" "user-identity" {
  location            = var.location
  name                = "Function-App-managedIdentity"
  resource_group_name = var.rg_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = "test-flex-vnet"
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = ["10.1.0.0/16"]
  tags                = var.tags
}

resource "azurerm_subnet" "function-subnet" {
  name                 = "function-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.1.0/24"]
  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.App/environments"
    }
  }
  lifecycle {
    ignore_changes = [delegation]
  }
}


# resource "azapi_resource" "name" {
#   schema_validation_enabled = false
#   name                      = var.name
#   parent_id                 = data.azurerm_resource_group.my_rg.id
#   location                  = var.location
#   type                      = "Microsoft.Web/sites@2022-03-01"
#   tags                      = var.tags
#   body = {
#     kind = "functionapp,linux"
#     properties = {
#       serverFarmId = var.service_plan_id
#       httpsOnly    = true

#       siteConfig = {
#         appSettings = [
#           {
#             name  = "DEPLOYMENT_STORAGE_CONNECTION_STRING"
#             value = "DefaultEndpointsProtocol=https;AccountName=${var.storage_account_name};AccountKey=${var.storage_account_access_key};EndpointSuffix=core.windows.net"
#           },
#           {
#             name  = "AzureWebJobsStorage"
#             value = "DefaultEndpointsProtocol=https;AccountName=${var.storage_account_name};AccountKey=${var.storage_account_access_key};EndpointSuffix=core.windows.net"
#           },
#           {
#             name  = "test"
#             value = "test"
#           },
#         ]
#       }

#       functionAppConfig = {
#         deployment = {
#           storage = {
#             type  = "blobcontainer"
#             value = "https://${var.storage_account_name}.blob.core.windows.net/${var.storage_container_name}"
#             authentication = {
#               type                               = "storageaccountconnectionstring"
#               storageAccountConnectionStringName = "DEPLOYMENT_STORAGE_CONNECTION_STRING"
#             }
#           }
#         }
#         runtime = {
#           name    = "dotnet-isolated"
#           version = "8.0"
#         }
#         scaleAndConcurrency = {
#           instanceMemoryMB     = 2048
#           maximumInstanceCount = 40
#         }
#       }
#     }
#   }

# }
# resource "azapi_resource" "app2" {
#   schema_validation_enabled = false
#   name                      = "testflex2az"
#   parent_id                 = data.azurerm_resource_group.my_rg.id
#   location                  = var.location
#   type                      = "Microsoft.Web/sites@2022-03-01"
#   tags                      = var.tags
#   body = {
#     kind = "functionapp,linux"
#     properties = {
#       serverFarmId = var.service_plan_id
#       httpsOnly    = true

#       siteConfig = {
#         appSettings = [
#           {
#             name  = "DEPLOYMENT_STORAGE_CONNECTION_STRING"
#             value = "DefaultEndpointsProtocol=https;AccountName=${var.storage_account_name};AccountKey=${var.storage_account_access_key};EndpointSuffix=core.windows.net"
#           },
#           {
#             name  = "AzureWebJobsStorage"
#             value = "DefaultEndpointsProtocol=https;AccountName=${var.storage_account_name};AccountKey=${var.storage_account_access_key};EndpointSuffix=core.windows.net"
#           },
#         ]
#       }

#       functionAppConfig = {
#         deployment = {
#           storage = {
#             type  = "blobcontainer"
#             value = "https://${var.storage_account_name}.blob.core.windows.net/${var.storage_container_name}"
#             authentication = {
#               type                               = "storageaccountconnectionstring"
#               storageAccountConnectionStringName = "DEPLOYMENT_STORAGE_CONNECTION_STRING"
#             }
#           }
#         }
#         runtime = {
#           name    = "node"
#           version = "20"
#         }
#         scaleAndConcurrency = {
#           instanceMemoryMB     = 2048
#           maximumInstanceCount = 40
#         }
#       }
#     }
#   }
# }
