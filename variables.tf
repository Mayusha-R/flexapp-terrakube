# General
variable "location" {
  type = string
}
variable "rg_name" {
  type = string
}

# Storage
variable "storageAccount_name" {
  type = string
}
variable "storageAccount_tier" {
  type = string
}
variable "storageAccount_replication_type" {
  type = string
}

# Service Plan
variable "servicePlan_name" {
  type = string
}
variable "servicePlan_os_type" {
  type = string
}
variable "servicePlan_sku" {
  type = string
}

# Function App
variable "functionApp_name" {
  type = string
}
