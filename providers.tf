terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.3.0"
    }
    azapi = {
      source = "azure/azapi"
    }
  }
  backend "s3" {
    bucket = "terrakubebackend"
    key    = "terraform.tfstate"
    region = "eu-north-1"
  }

}

provider "azurerm" {
  features {}
  subscription_id                 = "664b6097-19f2-42a3-be95-a4a6b4069f6b"
  resource_provider_registrations = "none"
}

provider "azapi" {
  skip_provider_registration = true
}