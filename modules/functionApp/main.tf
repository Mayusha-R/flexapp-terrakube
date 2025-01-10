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
