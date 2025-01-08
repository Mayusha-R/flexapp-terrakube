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
  resource_provider_registrations = "none"
}

provider "azapi" {
  skip_provider_registration = true
}